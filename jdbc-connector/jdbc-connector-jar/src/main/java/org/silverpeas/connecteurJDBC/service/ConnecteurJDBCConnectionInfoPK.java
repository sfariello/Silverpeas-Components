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

package org.silverpeas.connecteurJDBC.service;

import com.stratelia.webactiv.util.WAPrimaryKey;

import java.io.Serializable;

public class ConnecteurJDBCConnectionInfoPK extends WAPrimaryKey implements Serializable {

  /**
   * 
   */
  private static final long serialVersionUID = 1L;

  /**
   * Constructor which set only the id
   * @since 1.0
   */
  public ConnecteurJDBCConnectionInfoPK(String id) {
    super(id);
  }

  /**
   * Constructor which set the id The WAPrimaryKey provides space and component name
   * @since 1.0
   */
  public ConnecteurJDBCConnectionInfoPK(String id, String space,
      String componentName) {
    super(id, space, componentName);
  }

  /**
   * Constructor which set the id The WAPrimaryKey provides space and component name
   * @since 1.0
   */
  public ConnecteurJDBCConnectionInfoPK(String id, WAPrimaryKey pk) {
    super(id, pk);
  }

  /**
   * Return the object root table name
   * @return the root table name of the object
   * @since 1.0
   */
  public String getRootTableName() {
    return "ConnecteurJDBCConnectionInfo";
  }

  public String getTableName() {
    return "SC_ConnecteurJDBC_ConnectInfo";
  }

  /**
   * Check if an another object is equal to this object
   * @return true if other is equals to this object
   * @param other the object to compare to this NodePK
   * @since 1.0
   */
  public boolean equals(Object other) {
    if (!(other instanceof ConnecteurJDBCConnectionInfoPK))
      return false;
    return (id.equals(((ConnecteurJDBCConnectionInfoPK) other).getId()))
        && (space.equals(((ConnecteurJDBCConnectionInfoPK) other).getSpace()))
        && (componentName.equals(((ConnecteurJDBCConnectionInfoPK) other)
        .getComponentName()));
  }

  /**
   * Returns a hash code for the key
   * @return A hash code for this object
   */
  public int hashCode() {
    return toString().hashCode();
  }

}