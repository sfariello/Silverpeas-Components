/**
 * Copyright (C) 2000 - 2012 Silverpeas
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * As a special exception to the terms and conditions of version 3.0 of
 * the GPL, you may redistribute this Program in connection with Free/Libre
 * Open Source Software ("FLOSS") applications as described in Silverpeas's
 * FLOSS exception.  You should have received a copy of the text describing
 * the FLOSS exception, and it is also available here:
 * "http://www.silverpeas.org/docs/core/legal/floss_exception.html"
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.silverpeas.questionReply.model;

import org.hamcrest.BaseMatcher;
import org.hamcrest.Description;

/**
 *
 * @author emmanuel.hugonnet@silverpeas.org
 */
public class ReplyMatcher extends BaseMatcher<Reply> {

  private Reply reply;

  /**
   * Creates a new matcher with the specified reply.
   * @param thereply the comment to match.
   * @return a reply matcher.
   */
  public static ReplyMatcher matches(final Reply thereply) {
    return new ReplyMatcher(thereply);
  }

  private ReplyMatcher(final Reply thereply) {
    this.reply = thereply;
  }

  @Override
  public boolean matches(Object item) {
    boolean match = false;
    if (item instanceof Reply) {
      Reply actual = (Reply) item;
      match = reply.getPK().getId().equals(actual.getPK().getId()) &&
          reply.getQuestionId() == actual.getQuestionId() &&
          reply.getCreationDate().equals(actual.getCreationDate()) &&
          reply.getTitle().equals(actual.getTitle()) &&
          reply.getContent().equals(actual.getContent()) &&
          reply.getCreatorId().equals(actual.getCreatorId()) &&
          reply.getPrivateReply() == actual.getPrivateReply() &&
          reply.getPublicReply() == actual.getPublicReply();
    }
    return match;
  }

  @Override
  public void describeTo(Description description) {
    description.appendValue(reply);
  }
}
