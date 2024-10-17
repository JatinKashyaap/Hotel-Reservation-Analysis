SELECT * FROM hotelreservation;

-- 1. What is the total no of Reservations in the dataset?
select count(Booking_ID) from hotelreservation;

 -- 2. Which meal plan is most popular among guest?
 select type_of_meal_plan , count(*) as count
 from hotelreservation
 group by type_of_meal_plan
 order by count desc
 limit 1;

  -- 3. What is the average price per room for reservations involving children?
  select avg(avg_price_per_room) from hotelreservation 
  where  no_of_children > 0;
  
  -- 4.How many reservations were made for the year 2018?

SELECT COUNT(*) AS reservations_count_2018
FROM hotelreservation
WHERE YEAR(STR_TO_DATE(arrival_date, '%d-%m-%Y')) = 2018;


  -- 5.What is the most commonly booked room type ?
  select room_type_reserved , count(*) as booked_room 
  from hotelreservation
  group by room_type_reserved
  order by booked_room desc
  limit 1;
  
 -- 6. How many reservations fall on a weekend ? 

Select COUNT(no_of_weekend_nights) AS Reservation_on_weekend
from hotelreservation
WHERE no_of_weekend_nights > 0;
 
 -- 7. What is the highest and lowest lead time for reservations? 
 select 
 max(lead_time) as highestleadtime,
 min(lead_time) as lowestleadtime
 from hotelreservation;
 
 -- 8. What is the most common market segment type for reservations?
 select market_segment_type, count(*) as total_reservation_for_each_market 
 from hotelreservation
 group by market_segment_type
 order by total_reservation_for_each_market  desc
 limit 1;
 
  -- 9.how many reservations have a booking status of "Confirmed"?
  
SELECT COUNT(*) AS number_of_confirmed_reservations
FROM hotelreservation
WHERE booking_status = 'Not_Canceled';

  -- 10. What is the total number of adults and children across all reservations?
  select sum(no_of_children) as total_children,
  sum(no_of_adults) as total_adults
  from hotelreservation;
  
   -- 11. What is the average number of weekend nights for reservations involving children?
  select avg(no_of_weekend_nights) as avg_weekend_nights 
  from hotelreservation where no_of_children>0;
  
   -- 12.How many reservations were made in each month of the year?
   
SELECT 
    MONTHNAME(STR_TO_DATE(arrival_date, '%d-%m-%Y %H:%i')) AS month_name,
    COUNT(*) AS number_of_reservations
FROM 
    hotelreservation
GROUP BY 
    MONTH(STR_TO_DATE(arrival_date, '%d-%m-%Y %H:%i')),
    MONTHNAME(STR_TO_DATE(arrival_date, '%d-%m-%Y %H:%i'))
ORDER BY 
    MONTH(STR_TO_DATE(arrival_date, '%d-%m-%Y %H:%i'));


   -- 13. What is the average number of nights (both weekend and weekday) spent by guests for each room type?
  select room_type_reserved, avg(no_of_weekend_nights+no_of_week_nights) as avg_no_of_nights
  from hotelreservation
  group by room_type_reserved
  order by avg_no_of_nights desc;
  
  -- 14.For reservations involving children, what is the most common room type, and what is the price for that room type? 
WITH ReservationsWithChildren AS (
    SELECT 
        room_type_reserved,
        avg_price_per_room
    FROM hotelreservation
    WHERE no_of_children > 0
),
MostCommonRoomType AS (
    SELECT 
        room_type_reserved,
        COUNT(*) AS reservation_count
    FROM ReservationsWithChildren
    GROUP BY room_type_reserved
    ORDER BY reservation_count DESC
    LIMIT 1
)
SELECT 
    r.room_type_reserved,
    COUNT(*) AS reservation_count,
    AVG(r.avg_price_per_room) AS average_price
FROM ReservationsWithChildren r
JOIN MostCommonRoomType m
ON r.room_type_reserved = m.room_type_reserved
GROUP BY r.room_type_reserved;


   
   -- 15. Find the market segment type that generates the highest average price per room?
   select market_segment_type, avg(avg_price_per_room) as highest_avg_price 
   from hotelreservation
   group by market_segment_type
   order by highest_avg_price desc
   limit 1;
   