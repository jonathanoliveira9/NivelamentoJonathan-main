require 'rails_helper'

RSpec.describe Grade, type: :model do
  subject { build(:grade) }

  it 'valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without code' do
    subject.code = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without year' do
    subject.year = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without hour_start' do
    subject.hour_start = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without hour end' do
    subject.hour_end = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without school_name' do
    subject.school_name = nil
    expect(subject).to_not be_valid
  end
end
