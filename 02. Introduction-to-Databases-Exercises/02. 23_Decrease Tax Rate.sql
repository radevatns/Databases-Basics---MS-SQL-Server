SELECT TaxRate FROM Payments
UPDATE Payments SET TaxRate = TaxRate*0.97
SELECT TaxRate FROM Payments