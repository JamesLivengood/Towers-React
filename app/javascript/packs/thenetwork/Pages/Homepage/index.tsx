import React, { FC } from 'react';
import { PageWithHeader } from '../../Common/Components/PageWithHeader';
import SpreadsheetUploader from '../../Common/Components/SpreadsheetUploader';

const Homepage: FC = (props) => {
    return (
        <PageWithHeader header={"Towers"}>
            <p>Upload tower sites:</p>
            <SpreadsheetUploader />
        </PageWithHeader>
    );
};

export { Homepage };