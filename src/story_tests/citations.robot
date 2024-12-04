*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset Citations
*** Test Cases ***
Adding article with negative year not possible
    Go To                               ${HOME_URL}
    Click Link                          New citation
    Wait Until Page Contains Element    author
    Wait Until Page Contains Element    title
    Wait Until Page Contains Element    year
    Wait Until Page Contains Element    booktitle
    Input Text                          author                   author1
    Input Text                          title                    title1
    Input Text                          year                     -1
    Click Button                        Create
    Page Should Contain                 Year must be a positive number

Added article should display properly in list
    Go To                               ${HOME_URL}
    Click Link                          New citation
    Wait Until Page Contains Element    author
    Wait Until Page Contains Element    title
    Wait Until Page Contains Element    year
    Wait Until Page Contains Element    booktitle
    Input Text                          author                      author10
    Input Text                          title                       title1
    Input Text                          year                        1999
    Click Button                        Create
    Sleep                               5s
    Page Should Contain                 author10
    Page Should Contain                 title1
    Page Should Contain                 1999
    Click Button                        Delete

Deleted article should not be displayed in list
    Go To                               ${HOME_URL}
    Click Link                          New citation
    Wait Until Page Contains Element    author
    Wait Until Page Contains Element    title
    Wait Until Page Contains Element    year
    Input Text                          author                      author1
    Input Text                          title                       title1
    Input Text                          year                        1999
    Click Button                        Create
    Page Should Contain                 author1
    Page Should Contain                 title1
    Page Should Contain                 1999
    Click Button                        Delete
    Page Should Not Contain             author1
    Page Should Not Contain             title1
    Page Should Not Contain             1999
