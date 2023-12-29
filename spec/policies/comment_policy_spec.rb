# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:admin) { create(:user, :admin) }
  let(:comment) { create(:comment, user: user) }

  subject { described_class.new(user, comment) }

  it 'allows destroy a comment for an admin' do
    subject = described_class.new(admin, comment)
    expect(subject.destroy?).to be_truthy
  end

  it 'allows destroy comment for a signed-in user' do
    subject = described_class.new(user, comment)
    expect(subject.destroy?).to be_truthy
  end
end
