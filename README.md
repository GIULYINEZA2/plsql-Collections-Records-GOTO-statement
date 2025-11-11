
# 🎓 Student Grade Management System
## PL/SQL Collections, Records, and GOTO Statements

**Student Name:** Ndayishimiye Ineza Giuly

**Student ID:** 27390

---

### 🧩 Problem Definition

**Context:**  
A university requires an automated system to manage student grades across multiple courses. The system must process enrollments, calculate GPAs, identify at-risk students, and generate detailed performance reports.

**Business Requirements:**
1. Store and process multiple students' information efficiently.  
2. Calculate individual course grades and overall GPA.  
3. Categorize students by academic performance levels.  
4. Identify at-risk students requiring academic support.  
5. Generate comprehensive reports for both students and departments.

**Technical Challenges:**
- Managing heterogeneous data (students, courses, enrollments).  
- Efficiently processing multiple records and relationships.  
- Handling exceptions and data anomalies.  
- Using controlled flow for complex validation and classification logic.

---

## 🧱 Solution Architecture

### **Data Structures Used**

1. **Collections**
   - **VARRAY:** Fixed-size collection (max 6) for student course grades.
   - **Nested Table:** Dynamic collection for remarks/warnings.
   - **Associative Array:** Department-level GPA statistics (key-value pairs).

2. **Records**
   - **User-Defined Record:** Represents a student’s academic profile.
   - **Composite Record:** Embeds collections within records.

3. **GOTO Statements**
   - Implements controlled flow for data validation and status categorization.
   - Used for error recovery and label-based branching.

---

## 💡 Key Concepts Demonstrated

### 1. VARRAY (Variable-Size Array)
- Fixed upper bound of 6 courses per student.  
- Dense collection (no gaps in indices).  
- Demonstrates `.EXTEND` and index-based access for grades.

### 2. Nested Table
- Dynamic, unbounded collection for remarks and warnings.  
- Can become sparse after deletions.  
- Demonstrates flexible and dynamic data handling.

### 3. Associative Array (Index-by Table)
- Stores department names as keys and cumulative GPAs as values.  
- Demonstrates `.FIRST`, `.NEXT`, and `.EXISTS` methods for iteration.

### 4. User-Defined Records
- Combines multiple data types into one logical structure.  
- Includes nested collections (grades and remarks).  
- Represents a complete student performance entity.

### 5. GOTO Statements
- Enables multi-path decision-making and error recovery.  
- Demonstrates structured flow using labels (`<<label_name>>`).  
- Avoids nested conditional complexity in business logic.

---

## ⚙️ Testing Instructions

1. **Run Schema Setup:**  
   Execute the `createTables.sql` and `insertData.sql` scripts to create and populate the schema.

2. **Run Main Program:**  
   Execute the `main-program.sql` PL/SQL block to run the student grade processing and reporting logic.

3. **Verify Output:**  
   Confirm the following:
   - Student reports are printed.
   - GPA and credit totals are correct.
   - Remarks display appropriate academic status.
   - Department statistics are calculated and displayed.
   - Flow control with GOTO executes properly.

---

## 📁 Project files

- `createTables.sql` — Creates the schema/tables used by the program (students, courses, enrollments, etc.).
- `insertData.sql` — Inserts sample data used for testing and demonstration.
- `main-program.sql` — The PL/SQL program implementing the student grade management logic (collections, records, GOTO, reports).
- `verifyData.sql` — Simple verification queries to check table population and results.

You can open and run these files in your SQL client (SQL*Plus, SQL Developer, or any Oracle-compatible client) in the order above: `createTables.sql` → `insertData.sql` → `main-program.sql` → `verifyData.sql`.

---

## 🖼️ Screenshots

Below are screenshots demonstrating schema creation, table population, report output, statistics, and the relationship diagram. Images are referenced relative to this repository's `screenshots/` folder.

- Tables created

  ![My Screenshot](https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/f9c4205d8a6bcb9c865d034a27eb5c7197900ae2/Screenshots/create%20tables.png)


- Rows inserted into students

 ![My Screenshot](https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/f9c4205d8a6bcb9c865d034a27eb5c7197900ae2/Screenshots/insert%20into%20students.png)

-Rows inserted into courses

   ![My Screenshot](https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/f9c4205d8a6bcb9c865d034a27eb5c7197900ae2/Screenshots/insert%20into%20courses.png)

-Rows inserted into enrollement


 ![My Screenshot](
https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/f9c4205d8a6bcb9c865d034a27eb5c7197900ae2/Screenshots/insert%20into%20enrollements%20.png)
 

- Student report output

  ![Student report](https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/f9c4205d8a6bcb9c865d034a27eb5c7197900ae2/Screenshots/output%201.png)

  
  ![Student report](https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/f9c4205d8a6bcb9c865d034a27eb5c7197900ae2/Screenshots/output%202.png)




- ER / relationship diagram

   ![My Screenshot](https://github.com/GIULYINEZA2/plsql-Collections-Records-GOTO-statement/blob/772ba4e45097d5214cd6a20ff9c37d46882622c8/Screenshots/relationship.png)

---

## 📝 Final notes

- This repository contains a PL/SQL demonstration of collections, records, and GOTO-based control flow for student grade management.
- Recommended execution order: `createTables.sql` → `insertData.sql` → `main-program.sql` → `verifyData.sql`.
- If you run into schema errors, ensure you're connected to an Oracle-compatible database and have sufficient privileges to create tables and execute PL/SQL blocks.
- Screenshots are included in the `screenshots/` folder to show expected outputs and the ER diagram.
# plsql-Collections-Records-GOTO-statement
