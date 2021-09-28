#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun 28 22:04:33 2020

@author: qinfang
"""
import pandas as pd
from db import DB
from pymysql import cursors


def fetch_all(query):
    db = DB.getDB()
    cur = db.connect().cursor()
    cur.execute(query)
    data = cur.fetchall()
    cur.close()
    return data


def fetch_all_dict(query):
    db = DB.getDB()
    cur = db.connect().cursor(cursor=cursors.DictCursor)
    cur.execute(query)
    data = cur.fetchall()
    cur.close()
    return data


def run_query(query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    cur.close()
    return


def insert(query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    cur.execute(query)
    dog_id = conn.insert_id()
    conn.commit()
    cur.close()
    return dog_id


def insert_dog(dog_query, breed):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    dog_id = -1
    try:
        print(dog_query)
        cur.execute(dog_query)
        dog_id = conn.insert_id()
        print(dog_id)
        dog_breed_queries = []
        for breed_id in breed:
            dog_breed_query = get_insert_dogbreed_query(dog_id,breed_id)
            print(dog_breed_query)
            dog_breed_queries.append(dog_breed_query)
        for query in dog_breed_queries:
            cur.execute(query)
    except Exception as e:
        print(e)
        conn.rollback()
        conn.close()
        return -1

    conn.commit()
    conn.close()
    return dog_id


def fetch_to_dataframe(query):
    db = DB.getDB()
    df = pd.read_sql(query, con=db.connect())
    return df


def get_login_query(email):
    query = "SELECT password FROM `User` WHERE email='%s';" % email
    return query


def get_isadmin_query(email):
    query = "SELECT if (count(*) > 0, 'yes','no') as isAdmin FROM Admin where email = '%s';" % email
    return query


def get_expense_by_date_and_vender(dog_id, date, vender):
    query = """
    SELECT expense_date, amount, description
FROM  `Expense`
WHERE Expense.expense_date = '%s' and Expense.vender_id = %s and Expense.dog_id = %s
""" % (date, vender, dog_id)

    return query


def add_one_expense(dog_id, expense_date, vender_id, amount, description):
    db = DB.getDB()
    query = """INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (%s, '%s', %s, %s, '%s');""" %(dog_id, expense_date, vender_id, amount, description)
    conn = db.connect()
    cur = conn.cursor()
    cur.execute(query)
    cur.close()
    conn.commit()

    return


def get_all_dog_query():
    query = """
SELECT  surrender_date, IF(aa.adoption_date is NULL, 'available', 'adopted') as adoptability_status, name, sex, 
alteration_status, birth_date, description, microchip_id, is_animal_control, a.breed_name, d.dog_id
FROM `Dog` d 
LEFT JOIN (SELECT db.dog_id, GROUP_CONCAT(b.breed_name order by b.breed_name SEPARATOR '/' ) as breed_name 
FROM `DogBreed` db 
JOIN `Breed` b 
ON b.breed_id = db.breed_id 
GROUP BY db.dog_id 
ORDER BY db.dog_id ) a 
ON a.dog_id = d.dog_id 
LEFT JOIN  `ApprovedApplication` aa 
ON d.dog_id = aa.dog_id
ORDER BY d.surrender_date ASC;
    """
    return query


def get_one_dog_query(dog_id):
    query = """
SELECT  surrender_date, IF(aa.adoption_date is NULL, 'available', 'adopted') as adoptability_status, name, sex, 
CAST(alteration_status AS UNSIGNED) AS alteration_status, birth_date, description, microchip_id, CAST(is_animal_control 
AS UNSIGNED) AS is_animal_control, a.breed_name, d.dog_id, surrender_reason
FROM `Dog` d 
LEFT JOIN (SELECT db.dog_id, GROUP_CONCAT(b.breed_name order by b.breed_name SEPARATOR '/' ) as breed_name 
FROM `DogBreed` db 
JOIN `Breed` b 
ON b.breed_id = db.breed_id 
GROUP BY db.dog_id 
ORDER BY db.dog_id ) a 
ON a.dog_id = d.dog_id 
LEFT JOIN  `ApprovedApplication` aa 
ON d.dog_id = aa.dog_id
WHERE d.dog_id = '%s'
ORDER BY d.surrender_date ASC;
    """ % dog_id
    return query


def get_adoption_date_query(dog_id):
    query = """SELECT adoption_date FROM ApprovedApplication where dog_id = %s ;""" % dog_id

    return query


def get_expense_by_dog_id_query(dog_id):
    query = """
    SELECT expense_date, amount, vender_name, description 
FROM  `Expense`, `Vender`
WHERE Expense.dog_id = '%s' and Vender.vender_id = Expense.vender_id 
""" % dog_id

    return query


def adoptable_dog_query():
    query = """SELECT name, sex, alteration_status, birth_date, description, microchip_id,     
              surrender_date, is_animal_control, a.breed_name, 
              IF(aa.adoption_date is NULL, 'available', 'adopted') as adoptability_status
FROM `Dog` d 
JOIN (SELECT db.dog_id, GROUP_CONCAT(b.breed_name order by b.breed_name SEPARATOR '/' ) as breed_name
FROM `DogBreed` db 
JOIN `Breed` b 
ON b.breed_id = db.breed_id 
GROUP BY db.dog_id 
ORDER BY db.dog_id, b.breed_name ) a 
ON a.dog_id = d.dog_id 
LEFT JOIN  `ApprovedApplication` aa 
ON d.dog_id = aa.dog_id
WHERE aa.adoption_date is NULL
ORDER BY d.surrender_date ASC;

    """
    return query


def get_pending_application_query():
    query = """SELECT t1.application_id, t1.applicant_email, t1.submit_date, t1.status, t1.co_applicant_first_name, 
              t1.co_applicant_last_name, t2.last_name, 
              t2.first_name, t2.phone_number, t2.address 
FROM `Application` t1
LEFT JOIN `Applicant` t2 on t1.applicant_email=t2.email
WHERE status='Pending';

    """
    return query


def get_breed_query():
    query = "SELECT breed_id,breed_name FROM `Breed`;"
    return query


def get_insert_dog_query(name,
                         sex,
                         birth_date,
                         description,
                         microchip_id,
                         alteration_status,
                         surrender_date,
                         surrender_reason,
                         surrender_name,
                         is_animal_control,
                         dog_adder_email):
    if microchip_id == '':
        return  """
    INSERT INTO `Dog` (name, birth_date, sex, description,  
                       alteration_status, surrender_date, surrender_reason,  
                       surrender_name, is_animal_control, dog_adder_email)
   VALUES ('{}', '{}', '{}', 
           '{}', {}, '{}', '{}',
           '{}', {},'{}');
    """.format( name,birth_date, sex, description, alteration_status, surrender_date,
                surrender_reason, surrender_name, is_animal_control, dog_adder_email)

    query = """
    INSERT INTO `Dog` (name, birth_date, sex, description, microchip_id, 
                       alteration_status, surrender_date, surrender_reason,  
                       surrender_name, is_animal_control, dog_adder_email)
   VALUES ('{}', '{}', '{}', '{}', 
           '{}', {}, '{}', '{}',
           '{}', {},'{}');
    """.format( name,birth_date, sex, description, microchip_id, alteration_status, surrender_date,
    surrender_reason, surrender_name, is_animal_control, dog_adder_email)

    return query

def get_insert_dogbreed_query(dog_id,breed_id):
    query = """INSERT INTO DogBreed (dog_id, breed_id) VALUES ({}, {});""".format(dog_id,breed_id)
    return query


def remove_unknown_breed_query(dog_id):
    query = """DELETE FROM DogBreed db WHERE db.dog_id = %s AND db.breed_id in (SELECT breed_id FROM Breed b 
    WHERE breed_name='Unknown');""" % dog_id

    return query


def get_vender_query():
    query = "SELECT vender_id, vender_name FROM `Vender`;"
    return query


def update_dog_info_query(dog_id, sex, alteration_status, microchip_id):
    if sex == '' and alteration_status == '' and microchip_id == '':
        return ''
    query = "UPDATE cs6400_summer2020_team022.Dog t SET "
    count = 0
    if sex != '':
        query += "t.sex='%s'" % sex
        count += 1
    if alteration_status != '':
        if count > 0:
            query += ", "
        query += "t.alteration_status=b'%s'" % alteration_status
        count += 1
    if microchip_id != '':
        if count > 0:
            query += ", "
        query += "t.microchip_id='%s'" % microchip_id
    query += " WHERE t.dog_id=%s" % dog_id

    return query


def insert_dog_breed(dog_id, breeds):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    dog_breed_queries = []
    if len(breeds) > 0:
        remove_unknown_query = remove_unknown_breed_query(dog_id)
        cur.execute(remove_unknown_query)
    for breed_id in breeds:
        dog_breed_query = get_insert_dogbreed_query(dog_id, breed_id)
        dog_breed_queries.append(dog_breed_query)
    for query in dog_breed_queries:
        cur.execute(query)
    cur.close()
    conn.commit()

def get_animal_control_surrender_query():
    query = """SELECT CONCAT( number.month,'/',number.year) month, monthly_count, breed, dog_id, sex, alteration_status, microchip_id,surrender_date
FROM
(SELECT YEAR(surrender_date) year, MONTH(surrender_date) month, COUNT(DISTINCT dog_id) monthly_count FROM `Dog`
WHERE is_animal_control = 1
AND surrender_date >= DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH,'%Y-%m-01')
GROUP BY YEAR(surrender_date), MONTH(surrender_date)) AS number, 
(SELECT a.dog_id, sex, alteration_status, microchip_id,surrender_date, YEAR(surrender_date) year, MONTH(surrender_date) month,
GROUP_CONCAT(DISTINCT breed_name ORDER BY breed_name SEPARATOR '/') breed FROM Dog a, DogBreed b, Breed c
WHERE a.dog_id = b.dog_id
AND b.breed_id = c.breed_id
AND is_animal_control = 1
AND surrender_date >= DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH,'%Y-%m-01')
GROUP BY a.dog_id, sex, alteration_status, microchip_id,surrender_date, YEAR(surrender_date), MONTH(surrender_date)) AS dog_details
WHERE number.year = dog_details.year
AND number.month = dog_details.month
ORDER BY number.year DESC, number.month DESC, dog_id;"""
    return query

def get_animal_control_adoption_query():
    query = """SELECT CONCAT(number.month,'/', number.year) month,  monthly_count, breed, dog_id, sex, alteration_status, microchip_id,surrender_date, days_in_rescue
FROM (SELECT YEAR(adoption_date) year, MONTH(adoption_date) month, COUNT(DISTINCT a.dog_id) monthly_count
FROM Dog a, ApprovedApplication b
WHERE is_animal_control = 1
AND adoption_date >= DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH,'%Y-%m-01')
AND a.dog_id = b.dog_id
AND DATEDIFF(adoption_date, surrender_date) > 60
GROUP BY YEAR(adoption_date), MONTH(adoption_date)) AS number,
     (SELECT a.dog_id, sex, alteration_status, microchip_id,surrender_date, YEAR(adoption_date) year, MONTH(adoption_date) month,
GROUP_CONCAT(DISTINCT breed_name ORDER BY breed_name SEPARATOR '/') breed, adoption_date - surrender_date AS days_in_rescue
     FROM Dog a, DogBreed b, Breed c, ApprovedApplication d
WHERE a.dog_id = b.dog_id
AND b.breed_id = c.breed_id
AND a.dog_id = d.dog_id
AND is_animal_control = 1
AND adoption_date >= DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH,'%Y-%m-01')
AND DATEDIFF(adoption_date, surrender_date) > 60
GROUP BY a.dog_id, sex, alteration_status, microchip_id,adoption_date, YEAR(adoption_date), MONTH(adoption_date), adoption_date - surrender_date) AS dog_details
WHERE number.year = dog_details.year
AND number.month = dog_details.month
order by number.year DESC, number.month DESC, days_in_rescue DESC, dog_details.dog_id DESC;"""
    return query

def get_animal_control_expense_query():
    query = """SELECT month,expenses FROM (
    SELECT CONCAT(MONTH(adoption_date),'/',YEAR(adoption_date)) month, SUM(amount) expenses, YEAR(adoption_date), MONTH(adoption_date) 
    FROM Dog a, ApprovedApplication b, Expense c 
    WHERE a.dog_id = b.dog_id
AND a.dog_id = c.dog_id
AND adoption_date >= DATE_FORMAT(CURDATE() - INTERVAL 6 MONTH,'%Y-%m-01')
GROUP BY CONCAT(MONTH(adoption_date),'/',YEAR(adoption_date)),YEAR(adoption_date), MONTH(adoption_date)
ORDER BY YEAR(adoption_date) DESC, MONTH(adoption_date) DESC) a;"""
    return query

def get_surrendered_dog_query():
    query = """ SELECT year, month, breed, count(distinct dog_id) total_dog  FROM (
SELECT DISTINCT YEAR(d.surrender_date) year,MONTH(d.surrender_date) month,d.dog_id,
GROUP_CONCAT(DISTINCT breed_name ORDER BY breed_name SEPARATOR '/') breed
FROM DogBreed db, Dog d, Breed b
WHERE d.dog_id = db.dog_id AND b.breed_id = db.breed_id
AND d.surrender_date >= DATE_FORMAT(CURDATE() - INTERVAL 12 MONTH,'%Y-%m-01')
AND d.surrender_date < DATE_FORMAT(CURDATE(), '%Y-%m-01')
GROUP BY db.dog_id,YEAR(d.surrender_date),MONTH(d.surrender_date)) a
GROUP BY year, month, breed
ORDER BY year, month, breed;"""
    return query

def get_adoption_dog_query():
    query = """SELECT year, month, breed, COUNT(DISTINCT dog_id) total_dog FROM
    (SELECT DISTINCT YEAR(a.adoption_date) year, MONTH(a.adoption_date) month,
    a.dog_id,
    GROUP_CONCAT( DISTINCT breed_name ORDER BY breed_name SEPARATOR '/') AS breed
FROM DogBreed db, ApprovedApplication a, Breed b WHERE a.dog_id = db.dog_id AND b.breed_id = db.breed_id
AND a.adoption_date >= DATE_FORMAT(CURDATE() - INTERVAL 12 MONTH,'%Y-%m-01')
AND a.adoption_date < DATE_FORMAT(CURDATE(),'%Y-%m-01')
GROUP BY db.dog_id, YEAR(a.adoption_date), MONTH(a.adoption_date)) a
GROUP BY year, month, breed
ORDER BY year, month, breed;
    """
    return query

def get_profit_query():
    query = """SELECT year, month, gc as breed, ROUND(IFNULL(monthly_revenue,0)) adoption_fee,
       ROUND(IFNULL(monthly_expense,0)) expense,
       ROUND(IFNULL(monthly_revenue,0)-IFNULL(monthly_expense,0)) profit FROM(
SELECT revenue.year, revenue.month,revenue.gc, monthly_revenue,monthly_expense FROM
(SELECT YEAR(adp.adoption_date) year, MONTH(adp.adoption_date) month, SUM(e.amount)*1.15 monthly_revenue, gc
FROM Expense e, ApprovedApplication adp,
(SELECT db.dog_id d_id, GROUP_CONCAT(b.breed_name order by b.breed_name SEPARATOR '/') AS gc
FROM DogBreed db, Breed b WHERE db.breed_id = b.breed_id GROUP BY db.dog_id
) gct
WHERE gct.d_id = e.dog_id
AND e.dog_id = adp.dog_id
AND adp.adoption_date >= DATE_FORMAT(CURDATE() - INTERVAL 12 MONTH,'%Y-%m-01')
AND adp.adoption_date < DATE_FORMAT(CURDATE(),'%Y-%m-01') GROUP BY gc, YEAR(adp.adoption_date), MONTH(adp.adoption_date)) AS revenue
LEFT JOIN
(SELECT YEAR(e.expense_date) year, MONTH(e.expense_date) month, SUM(e.amount) monthly_expense, gc
FROM `Expense` e left join
(SELECT db.dog_id d_id, GROUP_CONCAT(b.breed_name order by b.breed_name SEPARATOR '/') AS gc
FROM `DogBreed` db, `Breed` b WHERE db.breed_id = b.breed_id GROUP BY db.dog_id
) gct on gct.d_id = e.dog_id
WHERE e.expense_date >= DATE_FORMAT(CURDATE() - INTERVAL 12 MONTH,'%Y-%m-01')
AND e.expense_date < DATE_FORMAT(CURDATE(),'%Y-%m-01') GROUP BY gc, YEAR(e.expense_date), MONTH(e.expense_date) ORDER BY YEAR(e.expense_date), MONTH(e.expense_date)) AS cost ON cost.year = revenue.year
AND cost.month = revenue.month
AND cost.gc = revenue.gc
UNION
SELECT cost.year, cost.month, cost.gc,monthly_revenue,monthly_expense FROM (SELECT YEAR(e.expense_date) year, MONTH(e.expense_date) month, SUM(e.amount) monthly_expense, gc
FROM `Expense` e left join
(SELECT db.dog_id d_id, GROUP_CONCAT(b.breed_name order by
b.breed_name SEPARATOR '/') AS gc FROM `DogBreed` db, `Breed` b WHERE db.breed_id = b.breed_id GROUP BY db.dog_id
) gct on gct.d_id = e.dog_id
WHERE e.expense_date >= DATE_FORMAT(CURDATE() - INTERVAL 12 MONTH,'%Y-%m-01')
AND e.expense_date < DATE_FORMAT(CURDATE(),'%Y-%m-01') GROUP BY gc, YEAR(e.expense_date), MONTH(e.expense_date) ORDER BY YEAR(e.expense_date), MONTH(e.expense_date)) cost
left join
(SELECT YEAR(adp.adoption_date) year, MONTH(adp.adoption_date) month, SUM(e.amount)*1.15 monthly_revenue, gc
FROM Expense e, ApprovedApplication adp,
(SELECT db.dog_id d_id, GROUP_CONCAT(b.breed_name order by b.breed_name SEPARATOR '/') AS gc
FROM DogBreed db, Breed b WHERE db.breed_id = b.breed_id GROUP BY db.dog_id
) gct
WHERE gct.d_id = e.dog_id
AND e.dog_id = adp.dog_id
AND adp.adoption_date >= DATE_FORMAT(CURDATE() - INTERVAL 12 MONTH,'%Y-%m-01')
AND adp.adoption_date < DATE_FORMAT(CURDATE(),'%Y-%m-01') GROUP BY gc, YEAR(adp.adoption_date), MONTH(adp.adoption_date)) revenue
ON cost.year = revenue.year
AND cost.month = revenue.month AND cost.gc = revenue.gc) a
order by year,month,gc;"""
    return query



def get_insert_application_query(applicant_email,
                                 submit_date,
                                 co_applicant_first_name,
                                 co_applicant_last_name):
    if co_applicant_first_name and len(co_applicant_first_name) > 0 and co_applicant_last_name and len(co_applicant_last_name) > 0:

        query = """
        INSERT INTO `application` (applicant_email, submit_date, co_applicant_first_name, co_applicant_last_name)
        VALUES ('{}', '{}', '{}',  '{}');""".format(applicant_email, submit_date, co_applicant_first_name, co_applicant_last_name)
    elif co_applicant_first_name and len(co_applicant_first_name) > 0:
        query = """
        INSERT INTO `application` (applicant_email, submit_date, co_applicant_first_name)
        VALUES ('{}', '{}', '{}');""".format(applicant_email, submit_date, co_applicant_first_name)
    elif co_applicant_last_name and len(co_applicant_last_name) > 0:
        query = """
        INSERT INTO `application` (applicant_email, submit_date, co_applicant_last_name)
        VALUES ('{}', '{}', '{}');""".format(applicant_email, submit_date, co_applicant_last_name)

    else:
        query = """
        INSERT INTO `application` (applicant_email, submit_date)
        VALUES ('{}', '{}');""".format(applicant_email, submit_date)
    return query


def insert_application(query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    cur.execute(query)
    application_id = conn.insert_id()
    conn.commit()
    cur.close()
    return application_id

def get_isNew_applicant_query(email):
    query = "SELECT if (count(*)>0,'existed','new') as isNew FROM Applicant where email = '{}';".format(email)
    return query

def get_insert_applicant_query(email,
                               last_name,
                               first_name,
                               phone_number,
                               address):
    query = """
    INSERT INTO `applicant` (email, last_name, first_name, phone_number, address)
    VALUES ('{}', '{}', '{}', '{}', '{}');""".format(email, last_name, first_name, phone_number, address)
    #print(query)
    return query


def insert_applicant(query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    cur.execute(query)
    conn.commit()
    cur.close()


def insert_applicant_application(is_new, add_applicant_query,add_application_query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    application_id = -1
    try:
        if is_new:
            cur.execute(add_applicant_query)
        cur.execute(add_application_query)
        application_id = conn.insert_id()
    except Exception as e:
        print(e)
        conn.rollback()
        conn.close()
        return -1
    conn.commit()
    conn.close()
    return application_id


def get_search_applicant_query(lastname):
    query = f"""select DISTINCT a.applicant_email, ac.first_name, ac.last_name, ac.address, ac.phone_number, 
a.co_applicant_last_name, a.co_applicant_first_name  
from Application a, ApprovedApplication aa, Applicant ac where aa.application_id = a.application_id 
and ac.email = a.applicant_email and aa.adoption_date is null
and (a.co_applicant_last_name like '%{lastname}%' or ac.last_name like '%{lastname}%');"""

    return query


def get_recent_application(email, co_first_name, co_last_name):
    query = f"""select a.application_id, a.applicant_email, a.submit_date, ac.first_name, ac.last_name, ac.address, 
ac.phone_number, a.co_applicant_first_name, a.co_applicant_last_name from Application a, ApprovedApplication aa, 
Applicant ac
where a.applicant_email='{email}' and co_applicant_first_name='{co_first_name}' and co_applicant_last_name='{co_last_name}'
and aa.application_id = a.application_id and aa.adoption_date is null and ac.email=a.applicant_email
order by a.submit_date DESC limit 1;"""

    return query


def get_adoption_fee_query(dog_id):
    query = f"""select if(is_animal_control=0, sum(amount) * 1.15, sum(amount) * 0.15) as fee
from Expense e, Dog d where d.dog_id={dog_id} and e.dog_id=d.dog_id;
    """

    return query


def get_update_adoption_query(dog_id, adoption_date, application_id):
    query = f"""UPDATE ApprovedApplication t SET t.dog_id={dog_id}, t.adoption_date='{adoption_date}' WHERE t.application_id={application_id};"""

    return query


def get_approve_application_query(application_id):
    query = """UPDATE `Application` SET status = 'Approved' WHERE application_id = {};
    """.format(application_id)
    return query


def get_reject_application_query(application_id):
    query = """UPDATE `Application` SET Status = 'Rejected' WHERE application_id = {};
    """.format(application_id)
    return query


def get_insert_reject_query(application_id):
    query = """INSERT INTO `RejectedApplication` (application_id)
                       VALUES({});
    """.format(application_id)
    return query


def reject_application(reject_status_query, reject_insert_query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    try:
        cur.execute(reject_status_query)
        cur.execute(reject_insert_query)
    except Exception as e:
        print(e)
        conn.rollback()
        conn.close()
        return -1
    conn.commit()
    conn.close()
    return 0


def approve_application(approve_status_query):
    db = DB.getDB()
    conn = db.connect()
    cur = conn.cursor()
    try:
        cur.execute(approve_status_query)
    except Exception as e:
        print(e)
        conn.rollback()
        conn.close()
        return -1
    conn.commit()
    conn.close()
    return 0


def get_volunteer_query(target_name):
    query = f"""SELECT first_name, last_name, email, phone_number FROM `User`
WHERE LOWER(first_name) like '%{target_name}%' or LOWER(last_name) like '%{target_name}%' 
ORDER BY last_name, first_name;
    """
    return query


def get_breed_name_query(breed_id):
    query = f"SELECT breed_name FROM `Breed` WHERE breed_id= {breed_id};"
    return query


def get_expense_analysis_query():
    query = f"""SELECT v.vender_id, v.vender_name, SUM(e.amount) AS total_expense
FROM `Expense` e, `Vender` v
WHERE e.vender_id = v.vender_id
GROUP BY v.vender_id, v.vender_name
ORDER BY SUM(e.amount) DESC;
"""
    return query
