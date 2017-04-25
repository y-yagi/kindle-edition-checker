# Make `form_with` generate non-remote forms.
# TODO: remove commnet out after upgrade new version of rails
# Rails.application.config.action_view.form_with_generates_remote_forms = false
ActionView::Helpers::FormHelper.form_with_generates_remote_forms = false
