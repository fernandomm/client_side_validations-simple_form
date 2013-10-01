require 'action_view/test_helper'
require 'simple_form/cases/helper'

class ClientSideValidations::SimpleForm::FormHelperTest < ActionView::TestCase
  include ActionViewTestSetup
  include SimpleForm::ActionViewExtensions::FormHelper

  def client_side_form_settings_helper
    ""
  end

  def setup
    super
    ActionView::TestCase::TestController.any_instance.stubs(:action_name).returns('edit')
  end

  def test_simple_form_for
    simple_form_for(@post, :validate => true) do |f|
      concat f.input(:cost)
    end

    expected = %{window.ClientSideValidations.forms['new_post'] = {\"type\":\"SimpleForm::FormBuilder\",\"error_class\":\"error\",\"error_tag\":\"span\",\"wrapper_error_class\":\"field_with_errors\",\"wrapper_tag\":\"div\",\"wrapper_class\":\"input\",\"wrapper\":\"default\",\"validators\":{\"post[cost]\":{\"presence\":[{\"message\":\"can't be blank\"}]}}};}
    assert output_buffer.include?(expected)
  end

  def test_input_override
    simple_form_for(@post, :validate => true) do |f|
      concat f.input(:cost, :validate => false)
    end

    expected = %{window.ClientSideValidations.forms['new_post'] = {\"type\":\"SimpleForm::FormBuilder\",\"error_class\":\"error\",\"error_tag\":\"span\",\"wrapper_error_class\":\"field_with_errors\",\"wrapper_tag\":\"div\",\"wrapper_class\":\"input\",\"wrapper\":\"default\",\"validators\":{}};}
    assert output_buffer.include?(expected)
  end
end

