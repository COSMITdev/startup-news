require 'spec_helper'

describe Authentication do
  it { validate_presence_of :provider }
  it { validate_presence_of :uid }
end
