class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction

  # GET /students
  # GET /students.json
  def index
    # Sqlite3 causing some issue with query not supporting to includes. as of now added joins
    @search = Student.joins([:institution])
    @search = get_students_name_like(@search, params[:student_name]) if !params.blank? && !params[:student_name].blank?
    @search = get_institution_name(@search, params[:institution_name]) if !params.blank? && !params[:institution_name].blank?
    @search = name_sort(@search, params[:sort]) if !params.blank? && !params[:sort].blank? && params[:sort] == "full_name"
    @search = name_sort(@search, params[:sort]) if !params.blank? && !params[:sort].blank? && params[:sort] == "name"
    @students = @search
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:score, :full_name, :address, :phone, :institution_id)
    end

    def get_students_name_like(students, student_name = "")
      students.where("students.full_name Like ?", "%" + student_name + "%")
    end

    def get_institution_name(students, institution_name = "")
      students.where("institutions.name Like ?", "%" + institution_name + "%")
    end

    def name_sort(students, sort)
      students.order(sort + " " + sort_direction)
    end

    def sort_column
      return "full_name" if params[:sort] == "full_name"
      return "name" if params[:sort] == "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
