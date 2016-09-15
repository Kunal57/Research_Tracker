require 'rails_helper'

describe StudentsController do
  let!(:student) { Student.create!(name: "fun student", email: "me@me.com", password: "passwordz") }

  describe "GET #show" do
    it "responds with status code 200" do
      get :show, { id: student.id }
      expect(response).to have_http_status 200
    end

    it "assigns the correct student as @student" do
      get :show, { id: student.id }
      expect(assigns(:student)).to eq(student)
    end

    it "renders the :show template" do
      get :show, { id: student.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "responds with status code 200" do
      get :new
      expect(response).to have_http_status 200
    end
    it "assigns a new student to @student" do
      get :new
      expect(assigns(:student)).to be_a_new Student
    end

    it "renders the :new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  # describe "POST #create" do
  #   context "when valid params are passed" do
  #     it "responds with status code 302" do
  #       post :create, { student: Student.find(student) }
  #       expect(response).to have_http_status 302
  #     end

  #     it "creates a new student in the database" do
  #       post :create, { student: Student.find(student) }
  #       expect { post :create, { student: student }}.to change(Student, :count).by(1)
  #     end

  #     it "assigns the newly created student as @student" do
  #       post :create, { student: Student.find(student) }
  #       expect(assigns(:student)).to eq(student)

  #     end

  #     it "redirects to the created student" do
  #       post :create, { student: Student.find(student) }
  #       expect(response).to redirect_to student_url(student)
  #     end
  #   end

    # context "when invalid params are passed" do
    #   it "responds with status code 200" do
    #     post :create, { student:  }
    #     expect(response).to have_http_status 200
    #   end

    #   it "does not create a new student in the database" do
    #    expect { post :create, { student:  }}.not_to change(Student, :count)
    #   end

    #   # it "assigns the unsaved student as @student" do
    #   #   post :create, { student:  }
    #   #   expect(assigns(:student)).to match
    #   # end

    #   it "renders the :new template" do
    #     post :create, { student:  }
    #     expect(response).to render_template(:new)
    #   end
    # end
  # end
end
