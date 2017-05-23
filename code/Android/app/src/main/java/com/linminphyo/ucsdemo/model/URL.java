package com.linminphyo.ucsdemo.model;

import com.google.gson.annotations.SerializedName;
import java.io.Serializable;

/**
 * Created by lin on 5/21/17.
 */

public class URL implements Serializable {
  @SerializedName("small") String small;
  @SerializedName("regular") String regular;

  public String getSmall() {
    return small;
  }

  public URL setSmall(String small) {
    this.small = small;
    return this;
  }

  public String getRegular() {
    return regular;
  }

  public URL setRegular(String regular) {
    this.regular = regular;
    return this;
  }
}
