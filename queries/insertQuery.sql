
DECLARE @Node NCHAR(10);
DECLARE @FlowValue FLOAT;
DECLARE @PressureValue FLOAT;
DECLARE @VolumeInValue FLOAT;
DECLARE @OneDayConsumptionValue FLOAT;
DECLARE @ThirtyOneDaysConsumptionValue FLOAT;
DECLARE @Supply FLOAT;
DECLARE @Loss FLOAT;
DECLARE @Consumption FLOAT;
DECLARE @NoLeak FLOAT;

DECLARE flow_cursor CURSOR FOR
SELECT node, flow FROM flow;

DECLARE pressure_cursor CURSOR FOR
SELECT pressure FROM pressure;

DECLARE volume_in_cursor CURSOR FOR
SELECT volume_in FROM volume_in;

DECLARE one_day_consumption_cursor CURSOR FOR
SELECT one_day FROM one_day;

DECLARE thirtyone_days_consumption_cursor CURSOR FOR
SELECT thirtyone_days FROM thirtyone_days;

DECLARE supply_loss_cursor CURSOR FOR
SELECT supply, loss FROM supply_loss;

DECLARE leak_noleak_cursor CURSOR FOR
SELECT consumption, no_leak FROM leak_noleak;

OPEN flow_cursor;
OPEN pressure_cursor;
OPEN volume_in_cursor;
OPEN one_day_consumption_cursor;
OPEN thirtyone_days_consumption_cursor;
OPEN supply_loss_cursor;
OPEN leak_noleak_cursor;

FETCH NEXT FROM flow_cursor INTO @Node, @FlowValue;
FETCH NEXT FROM pressure_cursor INTO @PressureValue;
FETCH NEXT FROM volume_in_cursor INTO @VolumeInValue;
FETCH NEXT FROM one_day_consumption_cursor INTO @OneDayConsumptionValue;
FETCH NEXT FROM thirtyone_days_consumption_cursor INTO @ThirtyOneDaysConsumptionValue;
FETCH NEXT FROM supply_loss_cursor INTO @Supply, @Loss;
FETCH NEXT FROM leak_noleak_cursor INTO @Consumption, @NoLeak;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO Dashboard4 (Node, FlowValue, PressureValue, VolumeInValue, OneDayConsumptionValue, ThirtyOneDaysConsumptionValue, Supply, Loss, Consumption, NoLeak)
    VALUES (@Node, @FlowValue, @PressureValue, @VolumeInValue, @OneDayConsumptionValue, @ThirtyOneDaysConsumptionValue, @Supply, @Loss, @Consumption, @NoLeak);

    WAITFOR DELAY '00:00:01';

    FETCH NEXT FROM flow_cursor INTO @Node, @FlowValue;
    FETCH NEXT FROM pressure_cursor INTO @PressureValue;
    FETCH NEXT FROM volume_in_cursor INTO @VolumeInValue;
    FETCH NEXT FROM one_day_consumption_cursor INTO @OneDayConsumptionValue;
    FETCH NEXT FROM thirtyone_days_consumption_cursor INTO @ThirtyOneDaysConsumptionValue;
    FETCH NEXT FROM supply_loss_cursor INTO @Supply, @Loss;
    FETCH NEXT FROM leak_noleak_cursor INTO @Consumption, @NoLeak;
END;

CLOSE flow_cursor;
CLOSE pressure_cursor;
CLOSE volume_in_cursor;
CLOSE one_day_consumption_cursor;
CLOSE thirtyone_days_consumption_cursor;
CLOSE supply_loss_cursor;
CLOSE leak_noleak_cursor;

DEALLOCATE flow_cursor;
DEALLOCATE pressure_cursor;
DEALLOCATE volume_in_cursor;
DEALLOCATE one_day_consumption_cursor;
DEALLOCATE thirtyone_days_consumption_cursor;
DEALLOCATE supply_loss_cursor;
DEALLOCATE leak_noleak_cursor;
