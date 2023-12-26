# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:first_post) { create(:post, user: admin) }
  let(:second_post) { create(:post, user:) }

  subject { described_class.new(user, first_post) }

  it 'allows create a post for a signed-in user' do
    expect(subject.create?).to be_truthy
  end

  it 'does not allow creating a post for nill' do
    subject = described_class.new(nil, first_post)
    expect(subject.create?).to be_falsey
  end

  it 'allows destroy a post for an admin' do
    subject = described_class.new(admin, first_post)
    expect(subject.destroy?).to be_truthy
  end

  it 'allows destroy post for a signed-in user' do
    subject = described_class.new(user, second_post)
    expect(subject.destroy?).to be_truthy
  end
end
