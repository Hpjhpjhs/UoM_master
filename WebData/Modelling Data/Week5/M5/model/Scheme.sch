<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="article_author">
            <sch:let name="article" value="//article/@id"/>
            <sch:let name="author" value="//author/@username"/>
            <sch:assert test="count( @id=$article ) > 0">
                article <sch:value-of select="@id"/> does not occured in articl list
            </sch:assert>
            <sch:assert test="count( @username=$author ) > 0">
                author <sch:value-of select="@username"/> does not occured in author list
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="author_institution">
            <sch:let name="author" value="//author/@username"/>
            <sch:let name="institution" value="//institution/@id"/>
            <sch:assert test="count( @username=$author ) > 0">
                <sch:value-of select="@username"/> does not occured in author list
            </sch:assert>
            <sch:assert test="count( @id=$institution ) > 0">
                institutuon <sch:value-of select="@id"/> does not occured in institutions list
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="article">
            <sch:let name="arti" value="//article_author/@id"/>
            <sch:assert test="count( @id=$arti ) > 0">
                There is not author info for article <sch:value-of select="@id"/>
            </sch:assert>
            <sch:assert test="count(@id) = 1">
                Article id <sch:value-of select="@id"/> occurs more than once.Should be unique.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="author">
            <sch:let name="author" value="//article_author/@username"/>
            <sch:let name="institu" value="//author_institution/@username"/>
            <sch:assert test="count( @username=$author ) > 0">
                author <sch:value-of select="@username"/> has none article
            </sch:assert>
            <sch:assert test="count( @username=$institu ) > 0">
                <sch:value-of select="@username"/> does not belong to any institution.
            </sch:assert>
            <sch:assert test="count(@username) = 1">
                author username <sch:value-of select="@username"/> occurs more than once. Should be unique.
            </sch:assert>
        </sch:rule>
        
        <sch:rule context="institution">
            <sch:let name="institu" value="//author_institution/@id"/>
            <sch:assert test="count( @id=$institu ) > 0">
                No author belongs to institution <sch:value-of select="@id"/>
            </sch:assert>
            <sch:assert test="count(@id) = 1">
                institutions id <sch:value-of select="@id"/> occurs more than once. Should be unique.
            </sch:assert>
        </sch:rule>
   
    </sch:pattern>
    
</sch:schema>