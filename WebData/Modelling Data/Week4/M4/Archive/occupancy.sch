<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:title>A schematron for cooupancy.rnc</sch:title>
    <sch:ns prefix="rota" uri="occupancy.rnc"/>
    <sch:pattern>
        
        <sch:rule context="LastName">
            <sch:let name="ln" value="."/>
            <sch:let name="fn" value="../../@name"/>
            <!--1. Last name of each contact within a family must be the same as family name-->
            <sch:assert test=" $ln = $fn">
                1. The last name "<sch:value-of select="$ln"/>" 
                should coincide with its family name "<sch:value-of select="$fn"/>"
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="family">
            <sch:let name="fn" value="@name"/>
            <!-- 2. No family name occurs more than twice -->
            <sch:report test=" count( //family[@name=$fn] ) >=2">
               2. The family name "<sch:value-of select="$fn"/>" occures more than once
            </sch:report>
            <!-- 4.1 Every family must occurs in occupancy at least once-->
            <sch:report test=" count( //period[@family=$fn] ) = 0 ">
                4. The family name "<sch:value-of select="$fn"/>" never occur in any occupancy
            </sch:report>
            <!-- 7. For each period, each family occupied some house -->
            <sch:report test=" count( distinct-values(//period/@time) ) > count( distinct-values(//period[@family=$fn]/@time) ) ">
                7. The family "<sch:value-of select="$fn"/>" is not occupied any house in each periods: 
                <sch:value-of select="distinct-values(//period/@time) "/>
            </sch:report>
        </sch:rule>
        
        <sch:rule context="houses">
            <!-- 3. Exactly one castle house -->
            <sch:assert test=" count( //house[@castle = 'true'] ) = 1">
               3. There should be exactly one castle house.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="house">
            <sch:let name="hn" value="@name"/>
            <!-- 4.2 Every house occurs in occupancy at least once-->
            <sch:report test=" count( //period[@house = $hn] ) = 0 ">
               4. The family name "<sch:value-of select="$hn"/>" never occur in any occupancy
            </sch:report>
        </sch:rule>
        
        <sch:rule context="period">
            <sch:let name="family" value="@family"/>
            <sch:let name="house" value="@house"/>
            <sch:let name="time" value="@time"/>
            <!-- 5.1 every family in an occupancy occurs in one of the families -->
            <sch:report test=" count( //family[@name = $family] ) =0 ">
               5. The family "<sch:value-of select="$family"/>" from occupancy is not one of the families.              
            </sch:report>
            <!-- 5.2 every house in an occupancy occurs in one of the houses -->
            <sch:report test=" count( //house[@name = $house] ) =0 ">
               5. The house "<sch:value-of select="$family"/>" from occupancy is not one of the houses.      
            </sch:report>
            <!-- 6. For each priod, each house is occupied by at most one family -->
            <sch:report test=" count( //period[@house=$house and @time=$time ] ) >=2 ">
               6. The house "<sch:value-of select="$house"/>" is occupied by two families in same period
            </sch:report>
        </sch:rule>
    
    </sch:pattern>
</sch:schema>
