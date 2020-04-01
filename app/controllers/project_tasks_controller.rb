class ProjectTasksController < ApplicationController
  def kanban
    @project = Project.find(params[:project_id])
    render :layout => false
  end

  def create
    @project = Project.find(params[:project_id])
    @task = @project.project_tasks.new
    @task.description = params[:description]
    @task.agent_id = params[:agent]
    @task.start_date = params[:start_date]
    @task.due_date = params[:due_date]
    @task.status = ProjectTask::TODO
    
    pos = @project.project_tasks.where(status: ProjectTask::TODO).maximum('position')
    if pos.nil?
      pos = 1
    else
      pos += 1
    end
    @task.position = pos
    if @task.save
      render json: {message: "Tarea agregada", task: @task }
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task = ProjectTask.find(params[:id])
    if @task.destroy 
      render json: {message: "Tarea eliminada", task: @task }
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def move 
  	id = params[:id]
  	source = params[:source]
  	target = params[:target]
    sibling = params[:sibling]
  	
  	@task = ProjectTask.find(id)

  	if source.to_i == ProjectTask::TODO
      if target.to_i == ProjectTask::DOING
        @task.doing_date = DateTime.now
        msg = "Tarea movida a haciendo"
  	  end
  	end

  	if source.to_i == ProjectTask::DOING
      if target.to_i == ProjectTask::TODO
        @task.doing_date = nil
        msg = "Tarea movida a por hacer"
  	  end
      if target.to_i == ProjectTask::DONE
        @task.done_date = DateTime.now
        msg = "Tarea movida a hecha"
  	  end
  	end

  	if source.to_i == ProjectTask::DONE
      if target.to_i == ProjectTask::TODO
        @task.done_date = nil
        msg = "Tarea movida a por hacer"
  	  end
      if target.to_i == ProjectTask::DOING
        @task.done_date = nil
        msg = "Tarea movida a haciendo"
  	  end
  	end

    if source.to_i == target.to_i 
      msg = "Tarea reposicionada"
    end

    @task.status = target 

    
    # Posicionar
    if sibling.to_i != 0
      sibling_task = ProjectTask.find(sibling)
      @tasks = ProjectTask.where(project_id: @task.project_id, status: @task.status).order(:position)
      c = 0
      @tasks.each do |t|
        if t.id == sibling.to_i
          c = 1
        end
        if t.id == id.to_i 
          t.position = sibling_task.position
          t.save
          c = 0
        end 
        if c == 1 
          t.position = t.position + c
          t.save
        end
      end
    end


    if @task.save
      render json: {message: msg, task: @task }
    else
      render json: @task.errors, status: :unprocessable_entity
    end

  end
end
