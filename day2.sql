use mini_shop;
# todo: 카테고리 id(category_id)가 1인 모든 제품을 조회하세요.
select *
from products
where category_id = 1;
# todo: 서울에 위치한 모든 고객을 조회하세요.
select *
from customers c
where c.city = '서울';
# todo: 가격(price)이 10,000원 이상인 제품을 조회하세요.
select *
from products p
where p.price >= 10000
order by p.price desc;
# todo: 2023년 7월 10일 이후에 주문된 모든 주문을 조회하세요.
select *
from orders o
where o.order_date >= '2023-07-10';
# todo: 카테고리 id(category_id)가 3이고 가격(price)이 10,000원 이상인 제품을 조회하세요.
select *
from products
where category_id = 3 and price >= 10000
order by price desc;
# todo: 서울에 위치하고 우편번호(postal_code)가 '06'으로 시작하는 고객을 조회하세요.
select *
from customers
where city = '서울' and postal_code like '06%';
# todo: 카테고리 id(category_id)가 1이거나 가격(price)이 50,000원 이상인 제품을 조회하세요.
select *
from products
where category_id = 1 or price >= 50000
order by price desc;
# todo: 서울 또는 부산에 위치한 모든 공급업체를 조회하세요.
select *
from suppliers
# where city = '서울' or city = '부산';
where city in ('서울', '부산');
# todo: 카테고리 id(category_id)가 3이 아닌 모든 제품을 조회하세요.
select *
from products
where not category_id = 3;
# todo: 서울에 위치하지 않은 모든 고객을 조회하세요.
select *
from customers
where not city = '서울';

# todo: 카테고리 id(category_id)가 1 또는 2이고 가격(price)이 15,000원 이상인 제품을 조회하세요.
select *
from products
where category_id = 1 or category_id = 2 and price >= 15000
order by price desc;
# todo: 서울 또는 부산에 위치하며 우편번호(postal_code)가 '0'으로 시작하는 고객을 조회하세요.
select *
from customers
where city in ('서울', '부산') and postal_code like '0%';
# todo: 가격(price)이 10,000원에서 20,000원 사이인 제품을 조회하세요.
select *
from products
where price between 10000 and 20000;
# todo: 2023년 7월 10일부터 2023년 7월 20일 사이에 주문된 모든 주문을 조회하세요.
select *
from orders
where order_date between '2023-07-10' and '2023-07-20';
# todo: 카테고리 id(category_id)가 1, 3, 5인 제품을 조회하세요.
select *
from products
where category_id in (1,3,5);
# todo: 서울, 부산, 인천에 위치한 모든 고객을 조회하세요.
select *
from customers
where city in ('서울', '부산', '인천');
# todo: 제품명(product_name)이 '삼다'로 시작하는 제품을 조회하세요.
select *
from products
where product_name like '삼다%';
# todo: 제품명(product_name)에 '초콜릿'이 포함된 제품을 조회하세요.
select *
from products
where product_name like '%초콜릿%';
# todo: 고객명(customer_name)이 '마트'로 끝나는 고객을 조회하세요.
select *
from customers
where customer_name like '%마트';
# todo: 공급업체명(supplier_name)이 정확히 4글자인 공급업체를 조회하세요.
select *
from suppliers
where supplier_name like ('____');

# todo: 주문(orders) 테이블에서 배송업체 id(shipper_id)가 NULL인 주문을 조회하세요.
select *
from orders
where shipper_id is null ;
# todo: 공급업체(suppliers) 테이블에서 전화번호(phone)가 NULL이 아닌 공급업체를 조회하세요.
select *
from suppliers
where phone is not null;
# todo: 카테고리 id(category_id)가 2 또는 3이고, 가격(price)이 5,000원 이상 20,000원 이하인 제품을 조회하세요.
select *
from products
where category_id in (2, 3) and
      price between 5000 and 20000;
# todo: 주문일이 2023년 7월 15일 이후이고, 고객 id(customer_id)가 5보다 크며, 직원 id(employee_id)가 4 또는 5인 주문을
# 조회하세요.
select *
from orders
where order_date >= '2023-07-15' and customer_id > 5 and employee_id in (4, 5);
# todo: 제품명(product_name)에 '김'이 포함되어 있고, 가격(price)이 10,000원 이상인 제품을 조회하세요.
select *
from products
where product_name like '%김%' and price >= 10000;
# todo: 고객명(customer_name)이 '마트' 또는 '슈퍼'로 끝나고, 서울 또는 부산에 위치한 고객을 조회하세요.
select *
from customers
where customer_name like '%마트' or customer_name like '%슈퍼' and city in ('서울', '부산');
# todo: 2023년 7월에 주문되고, 배송업체 id(shipper_id)가 1인 모든 주문에 대해 주문 id(order_id)와 주문일(order_date)을
# 조회하세요.
select order_id, order_date
from orders
where order_date between '2023-07-00' and '2023-07-31' and shipper_id = 1;
