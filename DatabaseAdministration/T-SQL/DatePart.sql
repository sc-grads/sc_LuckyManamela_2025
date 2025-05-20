-- Assume current date is 2025-05-20 14:30:45

-- Extract the year
SELECT DATEPART(year, GETDATE()) AS YearPart;

-- Extract the month
SELECT DATEPART(month, GETDATE()) AS MonthPart;

-- Extract the day
SELECT DATEPART(day, GETDATE()) AS DayPart;

-- Extract the weekday
SELECT DATEPART(weekday, GETDATE()) AS WeekDayPart;

-- Extract the hour
SELECT DATEPART(hour, GETDATE()) AS HourPart;
