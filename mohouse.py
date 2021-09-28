#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun 28 21:10:31 2020

@author: qinfang
"""

from flask import Flask, render_template, request, redirect, url_for, flash, session
from datetime import timedelta, date
from db_utils import *

app = Flask(__name__)
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = timedelta(seconds=1)
app.secret_key = 'A0Zr98j/3yX R~XHH!jmN]LWX/,?RT'


@app.route("/")
def index():
    if 'user' in session:
        return redirect(url_for("dashboard"))

    return redirect(url_for('login'))


@app.route('/main')
def dashboard():
    if 'user' not in session:
        return redirect(url_for('login'))

    dog_query = get_all_dog_query()
    dogs = fetch_to_dataframe(dog_query)
    dogs['is_animal_control'] = dogs['is_animal_control'].apply(lambda x: 'yes' if x == b'\x01' else 'no')
    dogs['alteration_status'] = dogs['alteration_status'].apply(lambda x: 'altered' if x == b'\x01' else 'unaltered')
    current_num_dogs = dogs[dogs['adoptability_status'] == 'available'].shape[0]
    available_spaces = 50 - current_num_dogs
    user=session['user']
    isAdmin_query = get_isadmin_query(user)
    is_admin = fetch_all(isAdmin_query)[0][0]
    session['isAdmin'] = is_admin
    session['availableSpace'] = available_spaces

    return render_template('dashboard.html', dogs=dogs, available_spaces=available_spaces)


@app.route("/login", methods=['GET', 'POST'])
def login():
    if 'user' in session:
        return redirect(url_for("dashboard"))

    if request.method == 'POST':
        r_email = request.form['email']
        r_password = request.form['password']

        query = get_login_query(r_email)
        data = fetch_all(query)

        if len(data) == 1 and data[0][0] == r_password:
            session['user'] = request.form['email']
            return redirect(url_for("dashboard"))
        flash("Email and password were not matched in system.", "danger")

    return render_template('index.html')

@app.route("/logout", methods=['GET'])
def logout():
    session.clear()
    flash('You have been sign out cuccessfully!', 'success')
    return redirect(url_for("index"))


@app.route('/dog', methods=['GET', 'POST'])
def dog_detail():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        update_dog_query = update_dog_info_query(request.form.get('dog_id'),
                                             request.form.get('sex'),
                                             request.form.get('alteration_status'),
                                             request.form.get('microchip_id'),
                                             )
        if update_dog_query != '':
            run_query(update_dog_query)
        new_breeds = request.form.getlist('breed')
        insert_dog_breed(request.form.get('dog_id'), new_breeds)

    if 'dogid' in request.args or request.form.get('dog_id'):
        dog_id = request.form.get('dog_id')
        if 'dogid' in request.args:
            dog_id = request.args['dogid']
        query = get_one_dog_query(dog_id)
        data = fetch_all_dict(query)
        dog = []
        canUpdate = False
        surrender_date = data[0]['surrender_date']
        adoption_date_data = fetch_all(get_adoption_date_query(dog_id))
        adoption_date = ''
        if len(adoption_date_data) == 1:
            adoption_date = adoption_date_data[0][0]
        canAdopted = adoption_date == ''
        sex = ''
        for key, value in data[0].items():
            if (key == 'sex' and value == 'Unknown') \
                    or (key == 'alteration_status' and value == 0)\
                    or (key == 'microchip_id' and value is None)\
                    or (key == 'breed_name' and value == 'Unknown'):
                canUpdate = True

            if (key == 'alteration_status' and value == 0) \
                    or (key == 'microchip_id' and value is None):
                canAdopted = False
            if key == 'sex' and value != 'Unknown':
                sex = value

            if key == 'birth_date':
                dog.append(('age', calculate_age(value)))
                dog.append((key, value))
            elif key == 'alteration_status' and value == 1:
                if sex == 'Male':
                    dog.append((key, 'Neutered'))
                elif sex == 'Female':
                    dog.append((key, 'Spayed'))
                else:
                    dog.append((key, 'Altered'))
            elif key == 'is_animal_control':
                dog.append((key, 'Yes' if value == 1 else 'No'))
            else:
                dog.append((key, value))
        query = get_expense_by_dog_id_query(dog_id)
        expenses = fetch_all_dict(query)

        breed_query = get_breed_query()
        breeds = fetch_to_dataframe(breed_query)
        return render_template('dog_detail.html', dog=dog, expenses=expenses, dog_id=dog_id,
                               surrender_date=surrender_date, adoption_date=adoption_date, canUpdate=canUpdate,
                               breeds=breeds, canAdopted=canAdopted)

    return redirect(url_for("dashboard"))


@app.route('/addapplication', methods=['GET','POST'])
def add_application():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == "POST":
        email = request.form['email']
        submit_date = request.form['submit_date']
        first_name = request.form['applicant_first_name']
        last_name = request.form['applicant_last_name']
        phone_number = request.form['phone_number']
        address = request.form['address']
        co_applicant_first_name = request.form['co_applicant_first_name']
        co_applicant_last_name = request.form['co_applicant_last_name']
        print(co_applicant_first_name)
        print(co_applicant_last_name)
        print(type(co_applicant_first_name))
        #print(status)
        # add applicant first for foreign key constraint
        isNew_query = get_isNew_applicant_query(email)
        is_new = fetch_all(isNew_query)[0][0]

        add_applicant_query = get_insert_applicant_query(email, last_name, first_name, phone_number, address)
        
        add_application_query = get_insert_application_query(email, submit_date, co_applicant_first_name, co_applicant_last_name)
        
        application_id = insert_applicant_application(is_new, add_applicant_query,add_application_query)
        if application_id == -1:
            flash("Failed to add new application.Please try again.", "danger")
            return redirect(url_for('add_application'))
        flash("Successfully added new application. Application id is:"+str(application_id), "success")
        return redirect(url_for('add_application'))

    return render_template('addapplication.html')


@app.route('/adddog',methods=['GET', 'POST'])
def add_dog():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == "POST":
        breed = request.form.getlist('breed')
        name = request.form['name']
        sex = request.form['sex']
        birth_date = request.form['birth_date']
        alteration_status = request.form['alteration_status']
        description = request.form['description']
        microchip_id = request.form['microchip_id']
        surrender_date = request.form['surrender_date']
        surrender_reason = request.form['surrender_reason']
        surrender_name = request.form['surrender_name']
        is_animal_control = request.form['is_animal_control']
        dog_adder_email = session['user']
        print(name.lower())
        print(name.lower() == "uga")
        
        if name.lower() == "uga":
            for breed_id in breed:               
                breed_name_query = get_breed_name_query(breed_id)
                breed_name = fetch_all(breed_name_query)[0][0]
                print('bulldog' in breed_name.lower())
                print(breed_name.lower())
                if 'bulldog' in breed_name.lower():
                    flash("Uga cannot be a bull dog name, pleas change a name", "danger")
                    return redirect(url_for('add_dog'))
            
        add_dog_query = get_insert_dog_query(name,
                         sex,
                         birth_date,
                         description,
                         microchip_id,
                         alteration_status,
                         surrender_date,
                         surrender_reason,
                         surrender_name,
                         is_animal_control,
                         dog_adder_email)

        #dog_breed_queries = []
        #for breed_id in breed:
           # dog_breed_query = get_insert_dogbreed_query(dog_id,breed_id)
            #dog_breed_queries.append(dog_breed_query)
        dog_id = insert_dog(add_dog_query, breed)
        if dog_id == -1:
            flash("Failed to add new dog, pleas check input data", "danger")
            return redirect(url_for('add_dog'))
        return redirect(url_for('dog_detail', dogid = dog_id))
        #return add_dog_query

    breed_query = get_breed_query()
    breeds = fetch_to_dataframe(breed_query)
    return render_template('adddog.html',breeds = breeds)


@app.route('/addexpense',methods=['GET', 'POST'])
def add_expense():
    if 'user' not in session:
        return redirect(url_for('login'))

    if 'dog_id' in request.args and 'surrender_date' in request.args and 'adoption_date' in request.args:
        query = get_vender_query()
        venders = fetch_all(query)

        dog_id = request.args['dog_id']
        surrender_date = request.args['surrender_date']
        adoption_date = request.args['adoption_date']
        return render_template('add_expense.html', dog_id=dog_id, venders=venders, surrender_date=surrender_date,
                               adoption_date=adoption_date)

    if request.method == "POST":
        form = request.form
        amount = form['amount']
        if amount.isnumeric():
            expense_check_query = get_expense_by_date_and_vender(form['dog_id'], form['date'], form['vender'])
            expense_check_data = fetch_all(expense_check_query)
            if len(expense_check_data) == 0:
                add_one_expense(form['dog_id'], form['date'], form['vender'], form['amount'], form['description'])
                return redirect(url_for('dog_detail', dogid=form['dog_id']))
            else:
                flash("You have duplicated expense for vender %s on %s" % (form['vender'], form['date']), category='danger')
        else:
            flash("Invalid amount value", category='danger')
        return redirect(url_for('add_expense', dog_id=form['dog_id'], surrender_date=form['surrender_date'],
                                adoption_date=form['adoption_date']))

    flash("Invalid dogId", "danger")
    return redirect(url_for("dashboard"))


@app.route('/viewpendingapplication')
def view_pending_application():
    if 'user' not in session:
        return redirect(url_for('login'))

    query = get_pending_application_query()
    pending_applications = fetch_to_dataframe(query)

    return render_template('viewpendingapplication.html', pending_applications = pending_applications)


@app.route("/approve")
def approve():
    if 'user' not in session:
        return redirect(url_for('login'))
    
    application_id = request.args['applicationid']
    approve_status_query = get_approve_application_query(application_id)
    approve_return = approve_application(approve_status_query)
    if approve_return == -1:
        flash("Failed to approve application. Please try again.", "danger")
        return redirect(url_for('view_pending_application'))

    flash("Successfully approved application #"+ str(application_id),"success")
    return redirect(url_for('view_pending_application'))


@app.route("/reject")
def reject():
    if 'user' not in session:
        return redirect(url_for('login'))
    application_id = request.args['applicationid']
    reject_status_query = get_reject_application_query(application_id)
    reject_insert_query = get_insert_reject_query(application_id)
    reject_return = reject_application(reject_status_query, reject_insert_query)
    if reject_return == -1:
        flash("Failed to reject application. Please try again.", "danger")
        return redirect(url_for('view_pending_application'))
    flash("Successfully rejected application #"+ str(application_id), "success")
    return redirect(url_for('view_pending_application'))

@app.route('/<reportname>')
def view_individual_report(reportname):
    if 'user' not in session:
        return redirect(url_for('login'))
    if reportname == 'acsurrender':
        animal_control_surrender_query = get_animal_control_surrender_query()
        animal_control_surrender = fetch_to_dataframe(animal_control_surrender_query)
        ac_surrender_count = animal_control_surrender.iloc[:, 0:2].drop_duplicates()
        animal_control_surrender['alteration_status'] = animal_control_surrender['alteration_status'].apply(
            lambda x: 'altered' if x == b'\x01' else 'unaltered')
        return render_template('animalcontrolsurrender.html',
                               animal_control_surrender=animal_control_surrender,
                               ac_surrender_count=ac_surrender_count)
    elif reportname == 'acadoption':
        animal_control_adoption_query = get_animal_control_adoption_query()
        animal_control_adoption = fetch_to_dataframe(animal_control_adoption_query)
        ac_adoption_count = animal_control_adoption.iloc[:, 0:2].drop_duplicates()
        animal_control_adoption['alteration_status'] = animal_control_adoption['alteration_status'].apply(
            lambda x: 'altered' if x == b'\x01' else 'unaltered')
        return render_template('animalcontroladoption.html',
                               animal_control_adoption=animal_control_adoption,
                               ac_adoption_count = ac_adoption_count)
    elif reportname == 'acexpense':
        animal_control_expense_query = get_animal_control_expense_query()
        animal_control_expense = fetch_to_dataframe(animal_control_expense_query)
        return render_template('animalcontrolexpense.html',animal_control_expense=animal_control_expense)

    elif reportname == 'surrender':
        surrendered_dog_query = get_surrendered_dog_query()
        surrendered_dog = fetch_to_dataframe(surrendered_dog_query)
        return render_template('surrender.html',surrendered_dog=surrendered_dog)

    elif reportname == 'adoption':
        adoption_dog_query = get_adoption_dog_query()
        adoption_dog = fetch_to_dataframe(adoption_dog_query)
        return render_template('adoption.html', adoption_dog=adoption_dog)

    elif reportname == 'profits':
        profit_query = get_profit_query()
        profit = fetch_to_dataframe(profit_query)
        return render_template('profits.html', profit=profit)


@app.route('/volunteer',methods=['GET', 'POST'])
def volunteer_lookup():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'GET':

        return render_template('volunteer.html', show_result=False)

    if request.method == 'POST':
        print(get_volunteer_query(request.form.get('target_name')))
        volunteers = fetch_to_dataframe(get_volunteer_query(request.form.get('target_name')))
        if volunteers.shape[0] > 0:
            return render_template('volunteer.html', show_result=True,
                               volunteers=volunteers)
        else:
            flash("No volunteer was found", "danger")
            return redirect(url_for("volunteer_lookup"))
    flash("Something is wrong when search volunteer", "danger")
    return redirect(url_for("dashboard"))


@app.route('/dog_adoption', methods=['GET', 'POST'])
def dog_adoption():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'GET':
        if 'dog_id' not in request.args:
            flash("Wrong dog id for adding dog adoption", "danger")
            return redirect(url_for("dashboard"))
        return render_template('search_application.html', show_result=False, dog_id=request.args['dog_id'])

    if request.method == 'POST':
        print(get_search_applicant_query(request.form.get('lastname')))
        applicants = fetch_all_dict(get_search_applicant_query(request.form.get('lastname')))

        return render_template('search_application.html', show_result=True, dog_id=request.form.get('dog_id'),
                               applicants=applicants)

    flash("Something is wrong when add dog adoption", "danger")
    return redirect(url_for("dashboard"))


@app.route('/dog_adoption_application', methods=['GET', 'POST'])
def dog_adoption_application():
    if 'user' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        if request.form.get('process') == 'search':
            recent_application = get_recent_application(request.form.get('applicant_email'),
                                                        request.form.get('co_applicant_first_name'),
                                                        request.form.get('co_applicant_last_name'))
            application = fetch_all_dict(recent_application)
            adoption_fee_query = get_adoption_fee_query(request.form.get('dog_id'))
            adoption_fee_data = fetch_all_dict(adoption_fee_query)[0]
            adoption_fee = 0
            if len(adoption_fee_data) == 1:
                adoption_fee = adoption_fee_data["fee"]
            hasData = len(application) == 1
            return render_template('dog_adoption_application.html', application=application, adoption_fee=adoption_fee,
                                   dog_id=request.form.get('dog_id'), hasData=hasData)

        if request.form.get('process') == 'update':
            update_query = get_update_adoption_query(request.form.get('dog_id'), request.form.get('adoption_date'),
                                                     request.form.get('application_id'))
            run_query(update_query)
            return redirect(url_for('dog_detail', dogid=request.form.get('dog_id')))

    flash("Something is wrong when add dog adoption", "danger")
    return redirect(url_for("dashboard"))


@app.route('/expenseanalysis', methods=['GET', 'POST'])
def expense_analysis():
    if 'user' not in session:
        return redirect(url_for('login'))

    query = get_expense_analysis_query()
    expenses = fetch_all_dict(query)

    return render_template('expense_analysis.html', expenses=expenses)


def calculate_age(born):
    today = date.today()
    y = today.year - born.year - ((today.month, today.day) < (born.month, born.day))
    m = 0
    if born.month > today.month:
        m = 12 - (born.month - today.month)
    else:
        m = today.month - born.month

    return (y, m)


if __name__ == "__main__":
    app.run(debug=True)
