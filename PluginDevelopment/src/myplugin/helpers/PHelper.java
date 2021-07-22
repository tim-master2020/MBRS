package myplugin.helpers;

import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Type;

public class PHelper {

    String attName;
    Type attType;
    String typeName;
    int lower;
    int upper;

    public PHelper(String attName, Type attType, String typeName, int lower, int upper) {
        this.attName = attName;
        this.attType = attType;
        this.typeName = typeName;
        this.lower = lower;
        this.upper = upper;
    }

    public String getAttName() {
        return attName;
    }

    public void setAttName(String attName) {
        this.attName = attName;
    }

    public Type getAttType() {
        return attType;
    }

    public void setAttType(Type attType) {
        this.attType = attType;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getLower() {
        return lower;
    }

    public void setLower(int lower) {
        this.lower = lower;
    }

    public int getUpper() {
        return upper;
    }

    public void setUpper(int upper) {
        this.upper = upper;
    }
}
