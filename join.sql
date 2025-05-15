use mini_shop;
# todo: 제품(products) 테이블과 카테고리(categories) 테이블을 조인하여 각 제품의 이름과 해당 카테고리 이름을 조회하세요.
select p.product_name as '제품의 이름', c.category_name as '카테고리 이름'
from products p
join categories c
on p.category_id = c.category_id;
# todo: 주문(orders) 테이블과 고객(customers) 테이블을 조인하여 각 주문의 주문 ID, 주문일, 고객 이름을 조회하세요.
select o.order_id as '주문 ID', o.order_date as '주문일', c.customer_name as '고객 이름'
from orders o
join customers c
on o.customer_id = c.customer_id;
# todo: 주문(orders), 고객(customers), 직원(employees) 테이블을 조인하여 주문 ID, 주문일, 고객 이름, 담당 직원의 이름(성과 이름 결합)을 조회하세요.
select o.order_id as '주문 ID', o.order_date as '주문일', c.customer_name as '고객 이름', e.name as '담장 직원 이름'
from orders o
join customers c
on o.customer_id = c.customer_id
join employees e
on o.employee_id = e.employee_id;
# todo: 제품(products), 공급업체(suppliers), 카테고리(categories) 테이블을 조인하여 제품 이름, 공급업체 이름, 카테고리 이름을 조회하세요.
select p.product_name as '제품 이름', s.supplier_name as '공급업체 이름', category_name as '카테고리 이름'
from products p
join suppliers s on p.supplier_id = s.supplier_id
join categories c on p.category_id = c.category_id;
# todo: 모든 고객과 그들이 한 주문을 조회하세요. 주문을 하지 않은 고객도 결과에 포함되어야 합니다.
select c.customer_name as '고객 이름', o.order_id as '주문 ID'
from customers c
left join orders o on c.customer_id = o.customer_id;
# todo: 모든 제품과 각 제품에 대한 주문 상세 정보를 조회하세요. 주문되지 않은 제품도 결과에 포함되어야 합니다.
select p.product_name as '상품 이름', od.quantity as '주문 갯수'
from products p
left join order_details od on p.product_id = od.product_id;
# todo: 모든 주문과 해당 주문을 처리한 직원을 조회하세요. 담당 직원이 없는 주문도 포함되어야 합니다.
select o.order_id as '주문 ID', e.name as '담당 직원'
from orders o
join employees e on o.employee_id = e.employee_id;
# todo: 모든 주문 상세와 해당 제품 정보를 조회하세요. 제품 정보가 없는 주문 상세도 포함되어야 합니다.
select *
from order_details od
left join products p on od.product_id = p.product_id;
# todo: 모든 고객과 모든 주문을 UNION으로 조회하세요. 주문이 없는 고객과 고객 정보가 없는 주문도 모두 결과에 포함되어야 합니다.
select *
from customers c
left join  orders o on c.customer_id = o.customer_id
union
select *
from customers c
right join orders o on c.customer_id = o.customer_id;
# todo: 고객(customers) 테이블에서 같은 도시에 있는 고객들을 쌍으로 조회하세요. (각 쌍은 한 번만 표시되어야 함)
select ch.customer_name, pa.customer_name
from customers ch
join customers pa on ch.city = pa.city and ch.customer_id < pa.customer_id;
# todo: 주문 상세 정보를 조회하되, 주문 ID와 제품 ID를 기준으로 조인하세요.
select *
from orders o
join order_details od on o.order_id = od.order_id
join products p on od.product_id = p.product_id;
# todo: 서울에 위치한 고객들의 주문 정보를 조회하세요.
select *
from customers c
left join orders o on c.customer_id = o.customer_id
where c.city = '서울';
# todo: 카테고리가 '음료'인 제품들 중 가격이 10,000원 이상인 제품의 이름, 가격, 공급업체 이름을 조회하세요.
select p.product_name, p.price, s.supplier_name
from products p
join categories c on p.category_id = c.category_id
join suppliers s on p.supplier_id = s.supplier_id
where c.category_name = '음료' and p.price >= 10000;
