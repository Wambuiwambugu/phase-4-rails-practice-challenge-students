class StudentsController < ApplicationController
    def index
        render json: Student.all, status: :ok
    end

    def show
        student = find_student_by_id
        if student
            render json: student, status: :ok
        else
            render_not_found
        end
    end

    def update
        student = find_student_by_id
        if student
            student.update(student_params)
            if student.valid?
                render json: student, status: :ok
            else
                render json: {error: student.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render_not_found
        end
    end

    def create
        student = Student.create(student_params)
        if student.valid?
            render json: student, status: :ok
        else
            render json: {error: student.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        student = find_student_by_id
        if student
            student.destroy
            head :no_content
        else
            render_not_found
        end 
    end

    private

    def student_params
        params.permit(:name, :age, :instructor_id)
    end

    def find_student_by_id
        Student.find_by(id: params[:id])
    end

    def render_not_found
        render json: {error: "Student not found"}, status: :not_found
    end
end
