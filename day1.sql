use mini_shop;

# todo: 모든 고객의 정보 조회
select * from customers;

# todo: 고객 테이블에서 이름과 도시만 조회
select customer_name, city
from customers;

# todo: 주문에서 고유한 고객 id 조회
select distinct customer_id
from orders;

# todo: 제품에서 고유한 카테고리 id를 조회
select distinct category_id
from products;

# todo: 제품을 가격의 오름차순으로 정렬하여 조회
select *
from products
order by price asc;

# todo: 직원(employees)을 생년월일(birth_date)의 내림차순으로 정렬하여 조회하세요.
select *
from employees
order by birth_date desc;

# todo: 제품(products)을 카테고리 ID(category_id)의 오름차순, 가격(price)의 내림차순으로 정렬하여 조회하세요.
select *
from products
order by category_id asc, price desc;

# todo: 고객(customers)을 국가(country)의 오름차순, 도시(city)의 오름차순으로 정렬하여 조회하세요.
select *
from customers
order by country asc, city desc;

# todo: 제품(products)에서 제품명(product_name)과 가격(price)을 조회하고, 가격이 높은 순서대로 정렬하세요.
select product_name, price
from products
order by price desc;

# todo: 가장 비싼 상위 5개 제품을 조회하세요.
select *
from products order by price desc limit 5;

# todo: 제품 이름(product_name)과 가격(price)을 조회하되, 가장 저렴한 10개 제품만 표시하세요.
select product_name, price
from products order by price asc limit 10;
