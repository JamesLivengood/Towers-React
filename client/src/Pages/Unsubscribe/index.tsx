import React, { FC } from 'react';
import { UnsubscribeButton } from './components/UnsubscribeButton';
import { gql } from 'apollo-boost';
import { useQuery } from '@apollo/react-hooks';
import { PageWithHeader } from '../../Common/Components/PageWithHeader';

const GET_CONTACT = gql`
    query UnsubscribeContact($id: ID!, $uk: String!) {
        unsubscribeContact(id: $id, unsubscribeKey: $uk){
            id
            firstName
            unsubscribedAt
        }
    }
`;

type RoutesMatch = {
    params: {
        contactId: string,
        unsubscribeKey: string
    }
};

type IProps = {
    match: RoutesMatch
};

const Unsubscribe: FC<IProps> = (props) => {
    const { contactId, unsubscribeKey } = props.match.params;
    const { loading, error, data } = useQuery(GET_CONTACT, {
        variables: {
            id: contactId,
            uk: unsubscribeKey
        },
    });

    if(loading) {
        return (
            <PageWithHeader header={"Unsubscribe"}>
                <p>Loading...</p>
            </PageWithHeader>
        );
    }
    if(error || !data.unsubscribeContact) {
        return (
            <PageWithHeader header={"Unsubscribe"}>
                <p>I couldn't find your account!</p>
            </PageWithHeader>
        );
    }
    const { firstName, unsubscribedAt } = data.unsubscribeContact;

    if(unsubscribedAt) {
        const unsubscribedSecondsAgo = (Date.now() - Date.parse(unsubscribedAt)) / 1000;
        if(unsubscribedSecondsAgo > 60 * 60) {
            return (
                <PageWithHeader header={"Unsubscribe"}>
                    <p>Hey {firstName},</p>
                    <p>You've already unsubscribed!</p>
                    <p>If you are still receiving my emails something has gone wrong!</p>
                    <p>Please reply to the email and say "NICK! STOP EMAILING ME!"</p>
                    <p>I'll make sure it never happens again! Sorry!</p>
                </PageWithHeader>
            );
        }
    }

    const buttonRenderer = (cid: number, uk: string, unsubscribedAt: any) => {
        if(unsubscribedAt) {
            return (
                <span className="unsubscribed">You've unsubscribed!</span>
            )
        }
        return (
            <UnsubscribeButton
                contactId={cid}
                unsubscribeKey={uk} />
        )
    }

    return (
        <PageWithHeader header={"Unsubscribe"}>
            <p>Oh no, {firstName}!</p>
            <p>
                I'll be sad to miss you from my broadcasts but hope we can stay in touch.
            </p>
            <p>
                I understand that our inboxes can get swamped so no hurt feelings (although I'll be spending the rest of today recovering).
            </p>
            <p>
                Just click the following button to unsubscribe:
            </p>
            <p>
                {buttonRenderer(parseInt(contactId), unsubscribeKey, unsubscribedAt)}
            </p>
        </PageWithHeader>
    );
};

export { Unsubscribe };