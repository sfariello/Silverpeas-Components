/**
 * Copyright (C) 2000 - 2009 Silverpeas
 *
 * This program is free software: you can redistribute it and/or modify it under the terms of the
 * GNU Affero General Public License as published by the Free Software Foundation, either version 3
 * of the License, or (at your option) any later version.
 *
 * As a special exception to the terms and conditions of version 3.0 of the GPL, you may
 * redistribute this Program in connection with Free/Libre Open Source Software ("FLOSS")
 * applications as described in Silverpeas's FLOSS exception. You should have received a copy of the
 * text describing the FLOSS exception, and it is also available here:
 * "http://www.silverpeas.org/docs/core/legal/floss_exception.html"
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without
 * even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License along with this program.
 * If not, see <http://www.gnu.org/licenses/>.
 */
package com.silverpeas.scheduleevent.service.model.dao;

import com.silverpeas.annotation.Repository;
import com.silverpeas.scheduleevent.service.model.beans.Response;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import org.springframework.transaction.annotation.Transactional;

@Repository("responseDao")
@Transactional
public class ResponseDaoImpl implements ResponseDao {

  @PersistenceContext
  private EntityManager theEntityManager;

  private EntityManager getEntityManager() {
    return theEntityManager;
  }

  @Override
  public void deleteResponse(Response response) {
    EntityManager entityManager = getEntityManager();
    Response attachedResponse = theEntityManager.merge(response);
    theEntityManager.remove(attachedResponse);
  }
}
