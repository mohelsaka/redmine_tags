# This file is a part of redmine_tags
# redMine plugin, that adds tagging support.
#
# Copyright (c) 2010 Aleksey V Zapparov AKA ixti
#
# redmine_tags is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_tags is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_tags.  If not, see <http://www.gnu.org/licenses/>.

module IssuesHelper
  include TagsHelper

  def sidebar_tags
    unless @sidebar_tags
      @sidebar_tags = []

      if :none != RedmineTags.settings[:issues_sidebar].to_sym
        @sidebar_tags = Issue.available_tags({
          :project => @project,
          :open_only => (1 == RedmineTags.settings[:issues_open_only].to_i)
        })
      end
    end

    @sidebar_tags
  end


  def inline_tags_cache
    if @inline_tags_cache.nil?
      @inline_tags_cache = false

      if 1 == RedmineTags.settings[:inline_cache].to_i
        @inline_tags_cache = Issue.available_tags({
          :project => @project
        }).map{ |v| v.to_s }
      end
    end

    @inline_tags_cache
  end


  def render_sidebar_tags
    render_tags_list(sidebar_tags, {
      :show_count => (RedmineTags.settings[:issues_show_count].to_i == 1),
      :open_only => (RedmineTags.settings[:issues_open_only].to_i == 1),
      :style => RedmineTags.settings[:issues_sidebar].to_sym
    })
  end
end
