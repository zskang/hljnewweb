package com.cabletech.station.domainobjects;

// default package

import java.util.Date;

import com.cabletech.commons.base.BaseDomainObject;

/**
 * PlanPatrolResultHalfYear generated by MyEclipse Persistence Tools
 */

public class PlanPatrolResultHalfYear extends PlanPatrolResult {

    // Fields

    private String batteryCapacitance;

    private String resistancetestTest;

    private String machineResistancetestTest;

    private String powerLineTest;

    private String earthLineTest;

    // Constructors

    /** default constructor */
    public PlanPatrolResultHalfYear() {
    }

    // Property accessors

    public String getBatteryCapacitance() {
        return this.batteryCapacitance;
    }

    public void setBatteryCapacitance(String batteryCapacitance) {
        this.batteryCapacitance = batteryCapacitance;
    }

    public String getResistancetestTest() {
        return this.resistancetestTest;
    }

    public void setResistancetestTest(String resistancetestTest) {
        this.resistancetestTest = resistancetestTest;
    }

    public String getMachineResistancetestTest() {
        return this.machineResistancetestTest;
    }

    public void setMachineResistancetestTest(String machineResistancetestTest) {
        this.machineResistancetestTest = machineResistancetestTest;
    }

    public String getPowerLineTest() {
        return this.powerLineTest;
    }

    public void setPowerLineTest(String powerLineTest) {
        this.powerLineTest = powerLineTest;
    }

    public String getEarthLineTest() {
        return this.earthLineTest;
    }

    public void setEarthLineTest(String earthLineTest) {
        this.earthLineTest = earthLineTest;
    }

}