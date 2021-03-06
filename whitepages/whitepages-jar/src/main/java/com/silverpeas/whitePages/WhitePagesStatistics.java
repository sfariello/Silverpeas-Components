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

/*--- formatted by Jindent 2.1, (www.c-lab.de/~jindent) 
 ---*/

package com.silverpeas.whitePages;

import com.silverpeas.silverstatistics.ComponentStatisticsInterface;
import com.silverpeas.silverstatistics.UserIdCountVolumeCouple;
import com.silverpeas.whitePages.control.CardManager;
import com.silverpeas.whitePages.model.Card;

import java.util.ArrayList;
import java.util.Collection;

/**
 * Class declaration
 *
 * @author
 */
public class WhitePagesStatistics implements ComponentStatisticsInterface {

  @Override
  public Collection<UserIdCountVolumeCouple> getVolume(String spaceId, String componentId)
      throws Exception {
    Collection<Card> c = getWhitePages(componentId);
    ArrayList<UserIdCountVolumeCouple> myArrayList = new ArrayList<UserIdCountVolumeCouple>(c.size());
    for (Card detail : c) {
      UserIdCountVolumeCouple myCouple = new UserIdCountVolumeCouple();
      myCouple.setUserId(detail.getUserId());
      myCouple.setCountVolume(1);
      myArrayList.add(myCouple);
    }

    return myArrayList;
  }

  public Collection<Card> getWhitePages(String componentId)
      throws WhitePagesException {
    return CardManager.getInstance().getCards(componentId);
  }

}
