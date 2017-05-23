package com.linminphyo.ucsdemo.model;

import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

/**
 * Created by lin on 5/21/17.
 */

public class PhotoPOJO implements Serializable {
  @SerializedName("user") private User user;

  @SerializedName("urls") private URL url;

  public URL getUrl() {
    return url;
  }

  public User getUser() {
    return user;
  }

  public PhotoPOJO setUrl(URL url) {
    this.url = url;
    return this;
  }

  public PhotoPOJO setUser(User user) {
    this.user = user;
    return this;
  }
}
