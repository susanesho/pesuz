require "spec_helper"

describe "Utility methods" do
  describe '#snakize' do
    context "PersonController" do
      it { expect("PersonController".snakize).to eq "person_controller" }
    end

    context "Person" do
      it { expect("Person".snakize).to eq "person" }
    end

    context "Todo::Person" do
      it { expect("Todo::Person".snakize).to eq "todo/person" }
    end

    context "PERSONController" do
      it { expect("PERSONController".snakize).to eq "person_controller" }
    end

    context "Person8Controller" do
      it { expect("Person8Controller".snakize).to eq "person8_controller" }
    end

    context "personcontroller" do
      it { expect("personcontroller".snakize).to eq "personcontroller" }
    end

    context "person" do
      it { expect("person".snakize).to eq "person" }
    end
  end

  describe '#camelize' do
    context "person_controller" do
      it { expect("person_controller".camelize).to eq "PersonController" }
    end
    context "person__todo_app" do
      it { expect("person__todo_app".camelize).to eq "PersonTodoApp" }
    end
    context "person" do
      it { expect("person".camelize).to eq "Person" }
    end
  end

  describe '#constantize' do
    context "`Hash`" do
      it { expect("Hash".constantize).to eq Hash }
    end

    context "`String`" do
      it { expect("String".constantize).to eq String }
    end

    context "`Array`" do
      it { expect("Array".constantize).to eq Array }
    end
  end

  describe '#to_plural' do
    context "girl" do
      it { expect("girl".to_plural).to eq "girls" }
    end

    context "buzz" do
      it { expect("buzz".to_plural).to eq "buzzes" }
    end

    context "story" do
      it { expect("story".to_plural).to eq "stories" }
    end

    context "toy" do
      it { expect("toy".to_plural).to eq "toys" }
    end

    context "scarf" do
      it { expect("scarf".to_plural).to eq "scarves" }
    end

    context "analysis" do
      it { expect("analysis".to_plural).to eq "analyses" }
    end

    context "curriculum" do
      it { expect("curriculum".to_plural).to eq "curricula" }
    end

    context "criterion" do
      it { expect("criterion".to_plural).to eq "criteria" }
    end

    context "amoeba" do
      it { expect("amoeba".to_plural).to eq "amoebae" }
    end

    context "focus" do
      it { expect("focus".to_plural).to eq "foci" }
    end

    context "bureau" do
      it { expect("bureau".to_plural).to eq "bureaux" }
    end
  end
end
