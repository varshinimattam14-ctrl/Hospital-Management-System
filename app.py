import os
from decimal import Decimal
from functools import wraps
from flask import Flask, render_template, request, redirect, url_for, session, flash, jsonify
import mysql.connector

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY', 'change-this-secret')


def db():
    return mysql.connector.connect(
        host=os.getenv('MYSQLHOST', os.getenv('DB_HOST', 'localhost')),
        port=int(os.getenv('MYSQLPORT', os.getenv('DB_PORT', '3306'))),
        user=os.getenv('MYSQLUSER', os.getenv('DB_USER', 'root')),
        password=os.getenv('MYSQLPASSWORD', os.getenv('DB_PASSWORD', 'mysql123')),
        database=os.getenv('MYSQLDATABASE', os.getenv('DB_NAME', 'hospital_management_sys')),
    )

def query(sql, params=(), fetch=True):
    con = db()
    cur = con.cursor(dictionary=True)
    try:
        cur.execute(sql, params)
        if fetch:
            return cur.fetchall()
        con.commit()
        return []
    finally:
        cur.close()
        con.close()


def one(sql, params=()):
    rows = query(sql, params)
    return rows[0] if rows else None


def login_required(fn):
    @wraps(fn)
    def wrapper(*args, **kwargs):
        if 'logged_in' not in session:
            return redirect(url_for('login'))
        return fn(*args, **kwargs)
    return wrapper


MODULES = [
    ('Dashboard', 'dashboard', '▦'),
    ('Patients', 'patients', '♙'),
    ('Doctors', 'doctors', '⚕'),
    ('Staff', 'staff', '♟'),
    ('Departments', 'departments', '▤'),
    ('Appointments', 'appointments', '◷'),
    ('Medical Records', 'medical_records', '▣'),
    ('Prescriptions', 'prescriptions', '✚'),
    ('Medicines', 'medicines', '✚'),
    ('Laboratory Tests', 'laboratory', '⌁'),
    ('Rooms', 'rooms', '▥'),
    ('Billing', 'billing', '₹'),
]

MODULE_CONFIG = {
    'doctors': {
        'title': 'Doctors', 'table': 'doctor', 'pk': 'Doctor_ID',
        'columns': ['Doctor_ID','Name','Specialization','Qualification','Phone','Department_ID'],
        'headers': ['Doctor ID','Name','Specialization','Qualification','Phone','Department'],
        'fields': [
            ('Doctor_ID','Doctor ID','number',True), ('Name','Name','text',True),
            ('Specialization','Specialization','text',False), ('Qualification','Qualification','text',False),
            ('Phone','Phone','text',False), ('Department_ID','Department','select',False)
        ],
        'search': ['Doctor_ID','Name','Specialization','Phone'],
        'order': 'Doctor_ID',
    },
    'staff': {
        'title': 'Staff', 'table': 'staff', 'pk': 'Staff_ID',
        'columns': ['Staff_ID','Name','Role','Phone'],
        'headers': ['Staff ID','Name','Role','Phone'],
        'fields': [('Staff_ID','Staff ID','number',True),('Name','Name','text',True),('Role','Role','role',True),('Phone','Phone','text',False)],
        'search': ['Staff_ID','Name','Role','Phone'], 'order': 'Staff_ID',
    },
    'departments': {
        'title': 'Departments', 'table': 'department', 'pk': 'Department_ID',
        'columns': ['Department_ID','Department_Name','Location','Phone'],
        'headers': ['Department ID','Department Name','Location','Phone'],
        'fields': [('Department_ID','Department ID','number',True),('Department_Name','Department Name','text',True),('Location','Location','text',False),('Phone','Phone','text',False)],
        'search': ['Department_ID','Department_Name','Location','Phone'], 'order': 'Department_ID',
    },
    'appointments': {
        'title': 'Appointments', 'table': 'appointment', 'pk': 'Appointment_ID',
        'columns': ['Appointment_ID','Patient_ID','Doctor_ID','Appointment_Date','Appointment_Time','Status'],
        'headers': ['Appointment ID','Patient','Doctor','Date','Time','Status'],
        'fields': [('Appointment_ID','Appointment ID','number',True),('Patient_ID','Patient','patient',True),('Doctor_ID','Doctor','doctor',True),('Appointment_Date','Date','date',False),('Appointment_Time','Time','time',False),('Status','Status','status',False)],
        'search': ['Appointment_ID','Appointment_Date','Status'], 'order': 'Appointment_Date DESC, Appointment_Time DESC',
    },
    'medical_records': {
        'title': 'Medical Records', 'table': 'medical_record', 'pk': 'Record_ID',
        'columns': ['Record_ID','Patient_ID','Diagnosis','Treatment','Record_Date','Notes'],
        'headers': ['Record ID','Patient','Diagnosis','Treatment','Record Date','Notes'],
        'fields': [('Record_ID','Record ID','number',True),('Patient_ID','Patient','patient',True),('Diagnosis','Diagnosis','text',False),('Treatment','Treatment','text',False),('Record_Date','Record Date','date',False),('Notes','Notes','textarea',False)],
        'search': ['Record_ID','Patient_ID','Diagnosis','Treatment'], 'order': 'Record_ID DESC',
    },
    'prescriptions': {
        'title': 'Prescriptions', 'table': 'prescription', 'pk': 'Prescription_ID',
        'columns': ['Prescription_ID','Patient_ID','Doctor_ID','Medicine_ID','Dosage','Duration'],
        'headers': ['Prescription ID','Patient','Doctor','Medicine','Dosage','Duration'],
        'fields': [('Prescription_ID','Prescription ID','number',True),('Patient_ID','Patient','patient',True),('Doctor_ID','Doctor','doctor',True),('Medicine_ID','Medicine','medicine',True),('Dosage','Dosage','text',False),('Duration','Duration','text',False)],
        'search': ['Prescription_ID','Patient_ID','Doctor_ID','Medicine_ID','Dosage'], 'order': 'Prescription_ID DESC',
    },
    'medicines': {
        'title': 'Medicines', 'table': 'medicine', 'pk': 'Medicine_ID',
        'columns': ['Medicine_ID','Medicine_Name','Category','Manufacturer','Price','Stock'],
        'headers': ['Medicine ID','Medicine Name','Category','Manufacturer','Price','Stock'],
        'fields': [('Medicine_ID','Medicine ID','number',True),('Medicine_Name','Medicine Name','text',True),('Category','Category','text',False),('Manufacturer','Manufacturer','text',False),('Price','Price','number',False),('Stock','Stock','number',False)],
        'search': ['Medicine_ID','Medicine_Name','Category','Manufacturer'], 'order': 'Medicine_ID',
    },
    'laboratory': {
        'title': 'Laboratory Tests', 'table': 'laboratory_test', 'pk': 'Test_ID',
        'columns': ['Test_ID','Patient_ID','Appointment_ID','Test_Name','Test_Date','Result'],
        'headers': ['Test ID','Patient','Appointment','Test Name','Test Date','Result'],
        'fields': [('Test_ID','Test ID','number',True),('Patient_ID','Patient','patient',True),('Appointment_ID','Appointment','appointment',False),('Test_Name','Test Name','text',False),('Test_Date','Test Date','date',False),('Result','Result','textarea',False)],
        'search': ['Test_ID','Patient_ID','Appointment_ID','Test_Name','Result'], 'order': 'Test_ID DESC',
    },
    'rooms': {
        'title': 'Rooms', 'table': 'room', 'pk': 'Room_ID',
        'columns': ['Room_ID','Room_Number','Room_Type','Floor','Availability'],
        'headers': ['Room ID','Room Number','Room Type','Floor','Availability'],
        'fields': [('Room_ID','Room ID','number',True),('Room_Number','Room Number','text',False),('Room_Type','Room Type','room_type',False),('Floor','Floor','number',False),('Availability','Availability','availability',False)],
        'search': ['Room_ID','Room_Number','Room_Type','Availability'], 'order': 'Room_ID',
    },
    'billing': {
        'title': 'Billing', 'table': 'billing', 'pk': 'Bill_ID',
        'columns': ['Bill_ID','Patient_ID','Appointment_ID','Consultation_Fee','Medicine_Charges','Laboratory_Charges','Room_Charges','Amount','Bill_Date','Payment_Status'],
        'headers': ['Bill ID','Patient','Appointment','Consultation','Medicine','Laboratory','Room','Total','Bill Date','Payment Status'],
        'fields': [('Bill_ID','Bill ID','number',True),('Patient_ID','Patient','patient',True),('Appointment_ID','Appointment','appointment',False),('Consultation_Fee','Consultation Fee','number',False),('Medicine_Charges','Medicine Charges','number',False),('Laboratory_Charges','Laboratory Charges','number',False),('Room_Charges','Room Charges','number',False),('Amount','Total Amount','number',False),('Bill_Date','Bill Date','date',False),('Payment_Status','Payment Status','payment',False)],
        'search': ['Bill_ID','Patient_ID','Appointment_ID','Payment_Status'], 'order': 'Bill_ID DESC',
    },
}


def lookups():
    return {
        'patients': query('SELECT Patient_ID, Name FROM patient ORDER BY Patient_ID'),
        'doctors': query('SELECT Doctor_ID, Name FROM doctor ORDER BY Doctor_ID'),
        'departments': query('SELECT Department_ID, Department_Name FROM department ORDER BY Department_ID'),
        'medicines': query('SELECT Medicine_ID, Medicine_Name FROM medicine ORDER BY Medicine_ID'),
        'appointments': query('SELECT Appointment_ID, Patient_ID, Appointment_Date FROM appointment ORDER BY Appointment_ID DESC'),
    }


def build_search(cfg, term):
    if not term:
        return '', []
    parts = []
    params = []
    for col in cfg['search']:
        parts.append(f"CAST({col} AS CHAR) LIKE %s")
        params.append(f'%{term}%')
    return ' WHERE ' + ' OR '.join(parts), params


def display_rows(name, rows):
    """Prepare MySQL values for HTML display and JSON used by edit popups.
    mysql-connector returns TIME columns as timedelta, which Flask/Jinja cannot
    serialize with the tojson filter. Convert date/time/decimal values to strings.
    Keep foreign-key IDs unchanged so edit forms receive valid IDs.
    """
    from datetime import date, datetime, time, timedelta
    for r in rows:
        for key, value in list(r.items()):
            if value is None:
                continue
            if isinstance(value, timedelta):
                total = int(value.total_seconds())
                hours, rem = divmod(total, 3600)
                minutes, seconds = divmod(rem, 60)
                r[key] = f"{hours:02d}:{minutes:02d}:{seconds:02d}"
            elif isinstance(value, (datetime, date, time)):
                r[key] = value.isoformat()
            elif isinstance(value, Decimal):
                r[key] = str(value)
    return rows


@app.route('/', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        if request.form.get('username') == 'admin' and request.form.get('password') == 'admin123':
            session['logged_in'] = True
            return redirect(url_for('dashboard'))
        flash('Invalid username or password.', 'error')
    return render_template('login.html')


@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))


@app.route('/dashboard')
@login_required
def dashboard():
    counts = {}
    for key, table in [('PATIENT','patient'),('DOCTOR','doctor'),('STAFF','staff'),('APPOINTMENT','appointment'),('MEDICINE','medicine'),('DEPARTMENT','department'),('ROOM','room'),('LABORATORY_TEST','laboratory_test'),('BILLING','billing'),('MEDICAL_RECORD','medical_record')]:
        try: counts[key] = query(f'SELECT COUNT(*) AS n FROM {table}')[0]['n']
        except Exception: counts[key] = 0
    appointments = query('''SELECT a.Appointment_ID, p.Name AS Patient, d.Name AS Doctor, a.Appointment_Date, a.Appointment_Time, a.Status FROM appointment a LEFT JOIN patient p ON a.Patient_ID=p.Patient_ID LEFT JOIN doctor d ON a.Doctor_ID=d.Doctor_ID ORDER BY a.Appointment_Date DESC, a.Appointment_Time DESC LIMIT 8''')
    return render_template('dashboard.html', modules=MODULES, counts=counts, appointments=appointments)


@app.route('/patients', methods=['GET','POST'])
@login_required
def patients():
    if request.method == 'POST':
        f = request.form
        try:
            query('INSERT INTO patient (Patient_ID,Name,DOB,Gender,Phone,Address,Blood_Group) VALUES (%s,%s,%s,%s,%s,%s,%s)', tuple(f.get(x) or None for x in ['Patient_ID','Name','DOB','Gender','Phone','Address','Blood_Group']), fetch=False)
            flash('Patient added successfully.', 'success')
        except Exception as e: flash(f'Error: {e}', 'error')
        return redirect(url_for('patients'))
    s = request.args.get('search','').strip()
    where, params = build_search({'search':['Patient_ID','Name','Phone']}, s)
    rows = query(f'SELECT Patient_ID,Name,DOB,Gender,Phone,Address,Blood_Group FROM patient{where} ORDER BY Patient_ID', params)
    return render_template('module.html', modules=MODULES, name='patients', title='Patients', cfg=patient_config(), data=rows, search=s, lookups=lookups())


def patient_config():
    return {
        'title':'Patients','table':'patient','pk':'Patient_ID','columns':['Patient_ID','Name','DOB','Gender','Phone','Address','Blood_Group'],
        'headers':['Patient ID','Name','DOB','Gender','Phone','Address','Blood Group'],
        'fields':[('Patient_ID','Patient ID','number',True),('Name','Name','text',True),('DOB','Date of Birth','date',False),('Gender','Gender','gender',False),('Phone','Phone','text',False),('Address','Address','textarea',False),('Blood_Group','Blood Group','blood',False)],
        'search':['Patient_ID','Name','Phone'],'order':'Patient_ID'
    }


@app.route('/module/<name>')
@login_required
def module(name):
    if name == 'patients': return redirect(url_for('patients'))
    cfg = MODULE_CONFIG.get(name)
    if not cfg: return redirect(url_for('dashboard'))
    s = request.args.get('search','').strip()
    where, params = build_search(cfg, s)
    sql = f"SELECT {','.join(cfg['columns'])} FROM {cfg['table']}{where} ORDER BY {cfg['order']}"
    try:
        rows = query(sql, params)
        rows = display_rows(name, rows)
        error = None
    except Exception as e:
        rows, error = [], str(e)
    return render_template('module.html', modules=MODULES, name=name, title=cfg['title'], cfg=cfg, data=rows, search=s, lookups=lookups(), error=error)


def get_cfg(name):
    return patient_config() if name == 'patients' else MODULE_CONFIG.get(name)


@app.route('/crud/<name>/save', methods=['POST'])
@login_required
def crud_save(name):
    cfg = get_cfg(name)
    if not cfg: return redirect(url_for('dashboard'))
    f = request.form
    values = [f.get(field) or None for field, *_ in cfg['fields']]
    if name == 'billing':
        nums = [Decimal(f.get(x) or '0') for x in ['Consultation_Fee','Medicine_Charges','Laboratory_Charges','Room_Charges']]
        total = sum(nums)
        values[cfg['columns'].index('Amount')] = str(total)
    try:
        exists = one(f"SELECT {cfg['pk']} FROM {cfg['table']} WHERE {cfg['pk']}=%s", (f.get(cfg['pk']),))
        if exists:
            assignments = ','.join(f'{c}=%s' for c in cfg['columns'] if c != cfg['pk'])
            update_values = [f.get(c) or None for c in cfg['columns'] if c != cfg['pk']]
            if name == 'billing': update_values[cfg['columns'][1:].index('Amount')] = str(sum(Decimal(f.get(x) or '0') for x in ['Consultation_Fee','Medicine_Charges','Laboratory_Charges','Room_Charges']))
            query(f"UPDATE {cfg['table']} SET {assignments} WHERE {cfg['pk']}=%s", tuple(update_values)+ (f.get(cfg['pk']),), fetch=False)
            flash(f"{cfg['title'][:-1] if cfg['title'].endswith('s') else cfg['title']} updated successfully.", 'success')
        else:
            query(f"INSERT INTO {cfg['table']} ({','.join(cfg['columns'])}) VALUES ({','.join(['%s']*len(cfg['columns']))})", tuple(values), fetch=False)
            flash(f"{cfg['title'][:-1] if cfg['title'].endswith('s') else cfg['title']} added successfully.", 'success')
    except Exception as e:
        flash(f'Error: {e}', 'error')
    return redirect(url_for('patients' if name=='patients' else 'module', name=name) if name!='patients' else url_for('patients'))


@app.route('/crud/<name>/delete/<pk>', methods=['POST'])
@login_required
def crud_delete(name, pk):
    cfg = get_cfg(name)
    if not cfg: return redirect(url_for('dashboard'))
    try:
        query(f'DELETE FROM {cfg["table"]} WHERE {cfg["pk"]}=%s', (pk,), fetch=False)
        flash('Record deleted successfully.', 'success')
    except Exception as e: flash(f'Cannot delete record: {e}', 'error')
    return redirect(url_for('patients' if name=='patients' else 'module', name=name) if name!='patients' else url_for('patients'))


@app.route('/patients/<int:patient_id>/history')
@login_required
def patient_history(patient_id):
    patient = one('SELECT * FROM patient WHERE Patient_ID=%s', (patient_id,))
    if not patient: return redirect(url_for('patients'))
    history = {
        'appointments': query('''SELECT a.*, d.Name Doctor FROM appointment a LEFT JOIN doctor d ON a.Doctor_ID=d.Doctor_ID WHERE a.Patient_ID=%s ORDER BY a.Appointment_Date DESC,a.Appointment_Time DESC''',(patient_id,)),
        'records': query('SELECT * FROM medical_record WHERE Patient_ID=%s ORDER BY Record_Date DESC',(patient_id,)),
        'prescriptions': query('''SELECT pr.*,d.Name Doctor,m.Medicine_Name FROM prescription pr LEFT JOIN doctor d ON pr.Doctor_ID=d.Doctor_ID LEFT JOIN medicine m ON pr.Medicine_ID=m.Medicine_ID WHERE pr.Patient_ID=%s ORDER BY pr.Prescription_ID DESC''',(patient_id,)),
        'tests': query('SELECT * FROM laboratory_test WHERE Patient_ID=%s ORDER BY Test_Date DESC',(patient_id,)),
        'billing': query('SELECT * FROM billing WHERE Patient_ID=%s ORDER BY Bill_Date DESC',(patient_id,)),
    }
    return render_template('patient_history.html', modules=MODULES, patient=patient, history=history)


@app.route('/api/billing-total')
@login_required
def billing_total():
    vals = [request.args.get(x, '0') or '0' for x in ['consultation','medicine','laboratory','room']]
    try: total = sum(Decimal(v) for v in vals)
    except Exception: total = Decimal('0')
    return jsonify({'total': f'{total:.2f}'})


if __name__ == '__main__':
    app.run(host='127.0.0.1', port=int(os.getenv('PORT','5001')), debug=True)
