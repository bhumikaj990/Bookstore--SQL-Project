-- Basic Queries

-- 1) Retrieve all books in the "Fiction" genre
select * from books where genre="Fiction";

-- 2) Find books published after the year 1950
select * from books where Published_year>1950;

-- 3) List all customers from the Canada
select * from customers where Country='italy';

-- 4) Show orders placed in November 2023
select * from orders where Order_Date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available
select sum(Stock) as total_stock from books;

-- 6) Find the details of the most expensive book
select * from books order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book
select * from orders where Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20
select * from orders where Total_Amount>20;

-- 9) List all genres available in the Books table
select distinct genre from books;

-- 10) Find the book with the lowest stock
select * from books order by Stock limit 1;

-- 11) Calculate the total revenue generated from all orders
select sum(Total_Amount)as revenue from orders;

-- Advance Queries

-- 1) Retrieve the total number of books sold for each genre.
select b.Genre,sum(o.Quantity) as total_books_sold from books as b join orders as o on b.Book_ID=o.Book_ID group by b.Genre;

-- 2) Find the average price of books in the "Fantasy" genre
select avg(Price) as avg_price from books where genre="Fantasy";

-- 3) List customers who have placed at least 2 orders
select Customer_ID,count(Order_Id) as order_count from orders  group by Customer_ID having order_count>=2;

select c.name,count(o.Order_ID) as order_count from orders as o join customers as c on c.Customer_ID=o.Customer_ID
 group by c.name having order_count>=1;
 
-- 4) Find the most frequently ordered book
select Book_ID,count(Order_Id) as order_count from orders group by Book_ID order by order_count desc limit 1;

select b.Title,count(o.Order_ID) as order_count from orders as o join books as b on b.Book_ID=o.Book_ID
 group by b.Title order by order_count desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre
select price,genre from books where genre="Fantasy" order by Price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author
select b.Author,sum(o.Quantity) as total_book_sold from orders as o join books as b on b.Book_ID=o.Book_ID group by b.Author;

-- 7) List the cities where customers who spent over $30 are loc
select distinct c.City,o.Total_Amount from customers as c join orders as o on c.Customer_ID=o.Customer_ID where o.Total_Amount>30;

-- 8) Find the customer who spent the most on orders
select c.Customer_ID,c.Name,sum(o.Total_Amount) as total_spend from customers as c join orders as o on c.Customer_ID=o.Customer_ID 
group by c.Customer_ID order by total_spend desc limit 1;

-- 9) Calculate the stock remaining after fulfilling all orders
select b.Book_ID,b.Title,b.Stock,coalesce(sum(Quantity),0) as order_quantity ,
b.Stock-coalesce(sum(Quantity),0) as remaining_quantity
from books as b left join orders as o on b.Book_ID=o.Book_ID group by b.Book_ID;