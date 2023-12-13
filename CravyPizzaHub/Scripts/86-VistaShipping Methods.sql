-- Crear la vista de ShippingMethods
CREATE OR REPLACE VIEW VistaShippingMethods AS
SELECT ShippingMethodId, ShippingMethodName, ShippingCost
FROM Shipping_Methods;
/
