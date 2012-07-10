# == Schema Information
#
# Table name: feed_entries
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  summary      :text
#  url          :string(255)
#  published_at :datetime
#  guid         :string(255)
#  hashe        :string(255)
#  source       :string(255)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe FeedEntry do
  pending "add some examples to (or delete) #{__FILE__}"
end
