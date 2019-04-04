module ApplicationHelper
    def auth_token # available everywhere in the views hell yeah specifically view helpers
        html = "<input type=\"hidden\" name=\"authenticity_token\""
        html += " value=\"#{form_authenticity_token}\""
        html.html_safe
    end

    def patch_method_override
        html = "<input type=\"hidden\" name=\"_method\""
        html += " value=\"PATCH\""
        html.html_safe
    end
end
