require 'rails_helper'

RSpec.describe Commontator, type: :lib do
  it 'responds to all attributes' do
    (
      Commontator::Config::ENGINE_ATTRIBUTES +
      Commontator::Config::COMMONTATOR_ATTRIBUTES +
      Commontator::Config::COMMONTABLE_ATTRIBUTES
    ).each do |attribute|
      expect(Commontator).to respond_to(attribute)
    end
  end

  it 'is configurable' do
    l1 = ->(controller) { Thread.current[:user] }
    l2 = ->(controller) { Thread.current[:user] }
    expect(l1).not_to eq l2
    Commontator.configure do |config|
      config.current_user_proc = l1
    end
    expect(Commontator.current_user_proc).to eq l1
    Commontator.configure do |config|
      config.current_user_proc = l2
    end
    expect(Commontator.current_user_proc).to eq l2
  end
end
