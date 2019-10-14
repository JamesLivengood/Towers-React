import React, { FC } from 'react';

const Homepage: FC = (props) => {
    return (
        <div className="container">
            <div className="row justify-content-center">
                <div className="col-lg-8 col-md-10 col-sm-12">
                    <nav>
                        <a href='https://www.nickoneill.com'>nickoneill.com</a>
                    </nav>
                    <article className="post">
                        <header className="post-header">
                            <h1 className="post-title">The Network</h1>
                        </header>

                        <div className="post-content">
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
                        </div>
                    </article>
                    <p><small>&copy; 2019, <a href='https://www.nickoneill.com'>Nick O'Neill</a></small></p>
                </div>
            </div>
        </div>
    );
};

export { Homepage };