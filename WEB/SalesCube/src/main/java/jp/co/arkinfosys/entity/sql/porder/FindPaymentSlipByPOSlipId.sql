SELECT
		PO.PO_SLIP_ID		AS PO_SLIP_ID

		,CASE 
		    WHEN SUPP.SUPPLIER_SLIP_ID IS NULL
			THEN ''

			WHEN (COALESCE(UNPAIDSUPPSLIP.UNPAIDSUPPSLIPCOUNT, 0) > 0 
				AND COALESCE(PAYINGSUPPSLIP.PAYINGSUPPSLIPCOUNT, 0) = 0
				AND COALESCE(PAIDSUPPSLIP.PAIDSUPPSLIPCOUNT, 0) = 0)  
			THEN /*slipPaymentStatusUnpaid*/

			WHEN (COALESCE(UNPAIDSUPPSLIP.UNPAIDSUPPSLIPCOUNT, 0) = 0 
				AND COALESCE(PAYINGSUPPSLIP.PAYINGSUPPSLIPCOUNT, 0) = 0
				AND COALESCE(PAIDSUPPSLIP.PAIDSUPPSLIPCOUNT, 0) > 0)  
			THEN /*slipPaymentStatusPaid*/ 

			ELSE /*slipPaymentStatusPaying*/ END	AS PAYMENT_STATUS

		,PAY.PAYMENT_DATE	AS PAYMENT_DATE
FROM
		PO_SLIP_TRN_/*$domainId*/ PO

	    LEFT OUTER JOIN SUPPLIER_SLIP_TRN_/*$domainId*/ SUPP
			ON PO.PO_SLIP_ID = SUPP.PO_SLIP_ID

		
		LEFT OUTER JOIN (
			SELECT
				COUNT(DISTINCT SUPPSLIP.PO_SLIP_ID) AS UNPAIDSUPPSLIPCOUNT
				,SUPPSLIP.PO_SLIP_ID AS PO_SLIP_ID
					FROM SUPPLIER_SLIP_TRN_/*$domainId*/ SUPPSLIP
				WHERE SUPPSLIP.STATUS = /*statusSupplierSlipUnpaid*/'0'
				GROUP BY
					SUPPSLIP.PO_SLIP_ID
		) UNPAIDSUPPSLIP
				ON PO.PO_SLIP_ID = UNPAIDSUPPSLIP.PO_SLIP_ID

		LEFT OUTER JOIN (
			SELECT
				COUNT(DISTINCT SUPPSLIP.PO_SLIP_ID) AS PAYINGSUPPSLIPCOUNT
				,SUPPSLIP.PO_SLIP_ID AS PO_SLIP_ID
					FROM SUPPLIER_SLIP_TRN_/*$domainId*/ SUPPSLIP
				WHERE SUPPSLIP.STATUS = /*statusSupplierSlipPaying*/'0' 
				GROUP BY
					SUPPSLIP.PO_SLIP_ID
		) PAYINGSUPPSLIP
				ON PO.PO_SLIP_ID = PAYINGSUPPSLIP.PO_SLIP_ID

		LEFT OUTER JOIN (
			SELECT
				COUNT(DISTINCT SUPPSLIP.PO_SLIP_ID) AS PAIDSUPPSLIPCOUNT
				,SUPPSLIP.PO_SLIP_ID AS PO_SLIP_ID
					FROM SUPPLIER_SLIP_TRN_/*$domainId*/ SUPPSLIP
				WHERE SUPPSLIP.STATUS = /*statusSupplierSlipPaid*/'0' 
				GROUP BY
					SUPPSLIP.PO_SLIP_ID
		) PAIDSUPPSLIP
				ON PO.PO_SLIP_ID = PAIDSUPPSLIP.PO_SLIP_ID

		LEFT OUTER JOIN PAYMENT_SLIP_TRN_/*$domainId*/ PAY
		ON PO.PO_SLIP_ID = PAY.PO_SLIP_ID

	WHERE
		PO.PO_SLIP_ID=/*poSlipId*/
	ORDER BY
		PAYMENT_DATE DESC LIMIT 1
