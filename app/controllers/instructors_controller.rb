class InstructorsController < ApplicationController
    def index
        instructors = Instructor.all
        render json: instructors, status: :ok
    end

    def show
        instructor = find_instructor_by_id
        if instructor
            render json: instructor, status: :ok
        else
            render_not_found
        end
    end

    def update
        instructor = find_instructor_by_id
        if instructor
            instructor.update(instructor_params)
            if  instructor.valid?
                render json: instructor, status: :ok
            else
                render json: {error: instructor.errors.full_messages}, status: :unprocessable_entity
            end
        else
            render_not_found
        end
    end 

    def create
        instructor = Instructor.create(instructor_params)
        if  instructor.valid?
            render json: instructor, status: :ok
        else
            render json: {error: instructor.errors.full_messages}, status: :unprocessable_entity
        end
    end

    def destroy
        instructor = find_instructor_by_id
        if instructor
            instructor.destroy
            head :no_content
        else
            render_not_found
        end
    end

    private

    def render_not_found
        render json: {error: "Instructor not found"}, status: :not_found
    end

    def find_instructor_by_id
        Instructor.find_by(id: params[:id])
    end

    def instructor_params
        params.permit(:name)
    end
end
