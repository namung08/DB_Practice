use mini_shop;
# todo: 각 카테고리(category_id)별 제품 수를 계산하세요.
select p.category_id, count(p.product_id)
from products p
group by p.category_id ;
# todo: 각 공급업체(supplier_id)별 제품의 평균 가격을 계산하세요.
select p.supplier_id, avg(p.price)
from products p
group by p.supplier_id ;
# todo: 각 주문(order_id)별 주문된 총 제품 수량(quantity)을 계산하세요.
select od.order_id, sum(od.quantity)
from order_details od
group by od.order_id ;
# todo: 각 고객(customer_id)별 주문 수를 계산하세요.
select customer_id, count(order_id)
from orders
group by customer_id;
# todo: 평균 가격이 15,000원 이상인 카테고리를 조회하세요.
select c.category_id, c.category_name, avg(p.price)
from categories c
join products p on c.category_id = p.category_id
group by c.category_id
having avg(p.price) >= 15000;
select p.category_id, avg(p.price)
from products p
group by p.category_id
having avg(p.price) >= 15000;
# todo: 5개 이상의 제품을 공급하는 공급업체(supplier_id)를 조회하세요.
select s.supplier_id, s.supplier_name, count(p.supplier_id)
from suppliers s
join products p on s.supplier_id = p.supplier_id
group by s.supplier_id, s.supplier_name
having count(p.supplier_id) >= 5;
SELECT supplier_id, COUNT(*) AS product_count
FROM products
GROUP BY supplier_id
HAVING product_count >= 5;
# todo: 총 주문량(quantity)이 50개 이상인 주문(order_id)을 조회하세요.
select order_id, count(quantity)
from order_details
group by order_id
having count(quantity) >= 50;
# todo: 3회 이상 주문한 고객(customer_id)을 조회하세요.
select customer_id, count(order_id)
from orders
group by customer_id
having count(order_id) >= 3;
# todo: 각 카테고리(category_id)와 공급업체(supplier_id) 조합별 제품 수를 계산하세요.
select category_id, supplier_id, count(*)
from products
group by category_id, supplier_id ;
# todo: 각 고객(customer_id)별, 연도별 주문 수를 계산하세요.
select customer_id, year(order_date), count(*)
from orders
group by customer_id, year(order_date) ;
# todo: 각 직원(employee_id)별, 고객(customer_id)별 처리한 주문 수를 계산하세요.
select employee_id, customer_id, count(*)
from orders
group by employee_id, customer_id;
# todo: 각 카테고리 이름(category_name)별 제품 수와 평균 가격을 계산하세요.
select c.category_name, count(p.product_id), avg(p.price)
from categories c
left join products p on c.category_id = p.category_id
group by c.category_name ;
# todo: 각 고객 이름(customer_name)별 총 주문 수와 주문한 고유한 제품 수를 계산하세요.
select c.customer_name, count(o.customer_id), sum(od.quantity)
from customers c
join mini_shop.orders o on c.customer_id = o.customer_id
join order_details od on o.order_id = od.order_id
group by c.customer_name;
