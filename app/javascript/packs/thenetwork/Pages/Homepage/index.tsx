import React, { FC } from 'react';
import { PageWithHeader } from '../../Common/Components/PageWithHeader';
const Homepage: FC = (props) => {
    return (
        <PageWithHeader header={"The Network"}>
            <p>Welcome!</p>
            <p>
            This is my personal network of friends and professional collaborators.
            </p>
            <p>
            If you've ended up on this site and aren't already part of the network, <a href='mailto: holler@nickoneill.com'>shoot me an email</a> and introduce yourself!
            </p>
            <p>
            I look forward to connecting!
            </p>
        </PageWithHeader>
    );
};

export { Homepage };