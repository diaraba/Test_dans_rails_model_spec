require 'rails_helper'

RSpec.describe Task, type: :model do
 describe "validation" do
    it "La validation de la tâche est invalide, si le titre n'est pas saisi" do
      task = Task.new(title: nil, description: "test", status: :todo, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Title can't be blank"]
    end

    it "Si le statut n'est pas saisi, la validation de la tâche n'est pas valide" do
      task = Task.new(title: "test", description: "test", status: nil, deadline: Time.current)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Status can't be blank"]
    end

    it "Si le deadline n'est pas saisi, la validation de la tâche n'est pas valide" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: nil)
      expect(task).to be_invalid
      expect(task.errors.full_messages).to eq ["Deadline can't be blank"]
    end


    it "La validation de la tâche est valide si la date limite d'achèvement est la date du jour" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current)
      expect(task.deadline).to be_within(1.second).of(Time.current)
    end

    it "La validation de la tâche n'est pas valide si la date d'achèvement est dépassée" do
      task = Task.new(title: "test", description: "test", status: :todo, deadline: Time.current - 1.day)
      expect(task).not_to be_valid
      expect(task.errors.full_messages).to eq ["Deadline must start from today."]
    end
  end
end
