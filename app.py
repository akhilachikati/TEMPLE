from flask import Flask, render_template, request, redirect, url_for, flash, session, jsonify, send_file
import mysql.connector
from werkzeug.security import generate_password_hash, check_password_hash
from datetime import datetime
import io
import xlsxwriter
from datetime import timedelta

app = Flask(__name__)
app.secret_key = 'your-secret-key'

# ---------------- DB Connection ------------------
def get_db_connection():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="1234@Mysql",
        database="temples",
        connection_timeout=10
    )

# ---------------- LOGIN ------------------
@app.route('/')
def login():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def do_login():
    username = request.form['username']
    password = request.form['password']

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM admin WHERE email = %s", (username,))
    user = cursor.fetchone()
    conn.close()

    if user and check_password_hash(user['password'], password):
        session['admin_id'] = user['admin_id']
        return redirect(url_for('dashboard'))
    else:
        flash('Invalid username or password', 'error')
        return redirect(url_for('login'))

# ---------------- DASHBOARD ------------------
@app.route('/dashboard')
def dashboard():
    if 'admin_id' not in session:
        return redirect(url_for('login'))
    return render_template('dashboard.html')

# ---------------- ADMIN FORM ------------------
@app.route('/admin')
def admin_form():
    if 'admin_id' not in session:
        return redirect(url_for('login'))
    return render_template('admin.html')

@app.route('/save_admin', methods=['POST'])
def save_admin():
    data = request.form
    pwd_hash = generate_password_hash(data['password'])

    created_at = data.get('created_at') or datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    updated_at = data.get('updated_at') or datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO admin 
        (first_name, last_name, gender, phone_number, email, aadhar_number, password, created_at, updated_at)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        data['first_name'], data['last_name'], data['gender'],
        data['phone_number'], data['email'], data['aadhar_number'],
        pwd_hash, created_at, updated_at
    ))
    conn.commit()
    conn.close()

    flash('Admin saved successfully', 'success')
    return redirect(url_for('dashboard'))

# ---------------- SEVA FORM ------------------
@app.route('/seva')
def seva_form():
    if 'admin_id' not in session:
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT seva_id, seva_type, description, seva_date, seva_time, day, duration, amount, slots_available 
        FROM seva
    """)
    sevas = cursor.fetchall()
    conn.close()

    return render_template('seva.html', sevas=sevas)


@app.route('/save_seva', methods=['POST'])
def save_seva():
    d = request.form
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        INSERT INTO seva
        (seva_type, description, seva_date, seva_time, day, duration, amount, slots_available)
        VALUES (%s,%s, %s, %s, %s, %s, %s, %s)
    """, (
        d['seva_type'], d['description'], d['seva_date'], d['seva_time'],
        d['day'], d['duration'], d['amount'], d['slots_available']
    ))
    conn.commit()
    conn.close()

    flash('Seva saved successfully', 'success')
    return redirect(url_for('dashboard'))

# ---------------- DEVOTEE FORM ------------------
@app.route('/devotees')
def devotee_form():
    if 'admin_id' not in session:
        return redirect(url_for('login'))

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("""
        SELECT devotee_id, first_name, last_name, gender, age, phone_number, email, aadhar_number, visit_date, visit_time, visit_day
        FROM devotees
        ORDER BY created_at DESC
    """)
    devotees = cursor.fetchall()
    conn.close()

    return render_template('devotees.html', devotees=devotees)

@app.route('/check_devotee')
def check_devotee():
    aadhar = request.args.get('aadhar')
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM devotees WHERE aadhar_number = %s", (aadhar,))
    result = cursor.fetchone()
    conn.close()
    return jsonify({'exists': bool(result)})

@app.route('/save_devotee', methods=['POST'])
def save_devotee():
    d = request.form
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM devotees WHERE aadhar_number = %s", (d['aadhar_number'],))
    if cursor.fetchone():
        return jsonify({'message': 'Devotee already exists'})

    cursor.execute("""
        INSERT INTO devotees
        (first_name, last_name, gender, age, phone_number, email, aadhar_number, visit_date, visit_time, visit_day)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        d['first_name'], d['last_name'], d['gender'], d['age'],
        d['phone_number'], d['email'], d['aadhar_number'],
        d['visit_date'], d['visit_time'], d['visit_day']
    ))
    conn.commit()
    conn.close()

    return jsonify({'message': 'Devotee saved successfully'})

# ---------------- REGISTRATIONS ------------------
@app.route('/registrations')
def registrations_form():
    if 'admin_id' not in session:
        return redirect(url_for('login'))

    aadhar = request.args.get('aadhar_number')
    devotee_data = None

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    if aadhar:
        cursor.execute("SELECT * FROM devotees WHERE aadhar_number = %s", (aadhar,))
        devotee_data = cursor.fetchone()

    cursor.execute("""
        SELECT 
            r.registration_id,
            d.first_name, d.last_name, d.aadhar_number,
            s.seva_type,
            r.payment_status, r.payment_amount,
            r.registration_status, r.donation,
            r.registration_date
        FROM registrations r
        JOIN devotees d ON r.devotee_id = d.devotee_id
        JOIN seva s ON r.seva_id = s.seva_id
        ORDER BY r.registration_date DESC
    """)
    registrations = cursor.fetchall()

    conn.close()

    return render_template('registrations.html', devotee=devotee_data, registrations=registrations)

@app.route('/save_registration', methods=['POST'])
def save_registration():
    d = request.form
    conn = get_db_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT devotee_id FROM devotees WHERE aadhar_number = %s", (d['aadhar_number'],))
    devotee_row = cursor.fetchone()
    devotee_id = devotee_row[0] if devotee_row else None
    admin_id = session.get('admin_id')

    cursor.execute("""
        INSERT INTO registrations
        (devotee_id, admin_id, seva_id, phone_number, email, aadhar_number, visit_date, visit_time, visit_day, payment_status, payment_amount, registration_status, donation)
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """, (
        devotee_id, admin_id, d.get('seva_id'), d.get('phone_number'),
        d.get('email'), d.get('aadhar_number'), d.get('visit_date'), d.get('visit_time'), d.get('visit_day'),
        d.get('payment_status', 'Pending'), d.get('payment_amount', 0), d.get('registration_status', 'Pending'), d.get('donation', 0)
    ))
    conn.commit()
    conn.close()
    flash('Registration saved successfully', 'success')
    return redirect(url_for('dashboard'))

# ---------------- AJAX GET DEVOTEE ------------------
@app.route('/get_devotee_by_aadhar/<aadhar_number>')
def get_devotee_by_aadhar(aadhar_number):
    try:
        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.execute("""
            SELECT devotee_id, first_name, last_name, phone_number, email, visit_date, visit_time, visit_day 
            FROM devotees WHERE aadhar_number = %s
        """, (aadhar_number,))
        devotee = cursor.fetchone()
        conn.close()

        if devotee:
            from datetime import datetime, timedelta  # make sure this is imported
            for k, v in devotee.items():
                if isinstance(v, datetime):
                    devotee[k] = v.isoformat()
                elif isinstance(v, timedelta):
                    devotee[k] = str(v)
            return jsonify(devotee)
        else:
            return jsonify({'error': 'Devotee not found'}), 404
    except Exception as e:
        import traceback
        traceback.print_exc()
        return jsonify({'error': str(e)}), 500


# ---------------- EXPORT TO EXCEL ------------------
@app.route('/export_registrations')
def export_registrations():
    conn = get_db_connection()
    cursor = conn.cursor()
    cursor.execute("""
        SELECT 
            r.registration_id,
            d.first_name, d.last_name, d.aadhar_number,
            s.seva_type,
            r.payment_status, r.payment_amount,
            r.registration_status, r.donation,
            r.visit_date, r.visit_time, r.visit_day,
            r.registration_date
        FROM registrations r
        JOIN devotees d ON r.devotee_id = d.devotee_id
        JOIN seva s ON r.seva_id = s.seva_id
        ORDER BY r.registration_date DESC
    """)
    rows = cursor.fetchall()
    conn.close()

    output = io.BytesIO()
    workbook = xlsxwriter.Workbook(output, {'in_memory': True})
    worksheet = workbook.add_worksheet("Registrations")

    headers = [
        "Registration ID", "First Name", "Last Name", "Aadhar Number",
        "Seva Type", "Payment Status", "Payment Amount",
        "Registration Status", "Donation", "Visit Date",
        "Visit Time", "Visit Day", "Registration Date"
    ]

    for col_num, header in enumerate(headers):
        worksheet.write(0, col_num, header)

    for row_num, row in enumerate(rows, 1):
        for col_num, value in enumerate(row):
            worksheet.write(row_num, col_num, str(value))

    workbook.close()
    output.seek(0)

    return send_file(
        output,
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        download_name='registrations.xlsx',
        as_attachment=True
    )

# ---------------- MAIN ------------------
@app.route('/logout')
def logout():
    session.clear()
    flash('Logged out successfully.', 'success')
    return redirect(url_for('login'))
if __name__ == '__main__':
    app.run(debug=True)
    