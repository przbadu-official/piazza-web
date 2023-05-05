# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  WINDOW_SIZE = [1400, 1400].freeze
  public_constant :WINDOW_SIZE

  driven_by :selenium, using: :chrome, screen_size: WINDOW_SIZE

  private

  def log_in(user, password: 'password')
    visit(login_path)

    fill_in(User.human_attribute_name(:email), with: user.email)
    fill_in(User.human_attribute_name(:password), with: password)

    click_button(I18n.t('sessions.new.submit'))
    assert_current_path(root_path)
  end

  def extract_primary_link_from_last_mail
    mail = ActionMailer::Base.deliveries.last
    mail_html = Nokogiri::HTML(mail.html_part.body.decoded)

    primary_link = mail_html.css('a.button').attr('href').value
    primary_link = URI(primary_link)
    "#{primary_link.path}?#{primary_link.query}"
  end
end

class MobileSystemTestCase < ApplicationSystemTestCase
  setup do
    visit root_path
    current_window.resize_to(375, 812)
  end

  teardown do
    current_window.resize_to(*ApplicationSystemTestCase::WINDOW_SIZE)
  end
end
