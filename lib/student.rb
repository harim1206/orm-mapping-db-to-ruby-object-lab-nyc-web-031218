# require_relative '../config/environment'
# require 'bundler'
# Bundler.require
# require 'sqlite3'
require "pry"

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object given a row from the database

    new_student = self.new
    new_student.id = row[0]
    new_student.name = row[1]
    new_student.grade = row[2]
    new_student
  end



  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
      SELECT *
      FROM students
    SQL

    DB[:conn].execute

  end



  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
    sql = <<-SQL
      SELECT *
      FROM students
      WHERE name = ?
      LIMIT 1
    SQL

    student = DB[:conn].execute(sql, name)

  end



  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end



  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end



  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * FROM Students
      WHERE name = ?
      LIMIT 1
    SQL

    result = DB[:conn].execute(sql, name).flatten

    student = Student.new
    student.id = result[0]
    student.name = result[1]
    student.grade = result[2]
    student

  end

  def self.count_all_students_in_grade_9
    sql = <<-SQL
      SELECT *
      FROM Students
      WHERE grade = 9

    SQL

    result = DB[:conn].execute(sql)

    # binding.pry

  end

  def self.students_below_12th_grade
    sql = <<-SQL
      SELECT *
      FROM Students
      WHERE grade < 12

    SQL

    result = DB[:conn].execute(sql)


    # binding.pry

  end

  def self.all
    sql = <<-SQL
      SELECT *
      FROM Students
    SQL

    result = DB[:conn].execute(sql)
    result.map{|student|
      Student.new_from_db(student)
    }

    # binding.pry

  end

  def self.first_X_students_in_grade_10(num)
    sql = <<-SQL
      SELECT *
      FROM Students
      WHERE grade = 10
      LIMIT ?

    SQL

    result = DB[:conn].execute(sql, num)

  end

  def self.first_student_in_grade_10
    sql = <<-SQL
      SELECT *
      FROM Students
      WHERE grade = 10
      LIMIT 1

    SQL

    result = DB[:conn].execute(sql).flatten
    student = Student.new
    student.id = result[0]
    student.name = result[1]
    student.grade = result[2]
    student
    # binding.pry

  end

  def self.all_students_in_grade_X(grade)

    sql = <<-SQL
      SELECT *
      FROM Students
      WHERE grade = ?


    SQL

    result = DB[:conn].execute(sql, grade)
    # binding.pry

  end


end

# Pry.start
#
