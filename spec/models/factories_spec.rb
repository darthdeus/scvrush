require 'spec_helper'

describe FactoryGirl do
  FactoryGirl.factories.each do |factory|
    context "with factory for :#{factory.name}" do
      subject { FactoryGirl.build(factory.name) }
      it { should be_valid }
    end
  end
end
