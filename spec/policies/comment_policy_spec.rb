# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, admin: true) }
  let(:comment) { create(:comment, user: admin) }
  let(:second_comment) { create(:comment, user:) }

  subject { described_class.new(user, comment) }

  it 'allows create a comment for a signed-in user' do
    expect(subject.create?).to be_truthy
  end

  it 'does not allow creating a comment for nill' do
    subject = described_class.new(nil, comment)
    expect(subject.create?).to be_falsey
  end

  it 'allows destroy a comment for an admin' do
    subject = described_class.new(admin, comment)
    expect(subject.destroy?).to be_truthy
  end

  it 'allows destroy comment for a signed-in user' do
    subject = described_class.new(user, second_comment)
    expect(subject.destroy?).to be_truthy
  end
end
