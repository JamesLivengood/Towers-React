import React, { FC } from 'react';

type IProps = {
    header: String
};

const PageWithHeader: FC<IProps> = (props) => {
    const { header, children } = props;

    return (
        <div className="container">
            <div className="row justify-content-center">
                <div className="col-lg-8 col-md-10 col-sm-12">
                    <nav>
                        <a href='https://www.nickoneill.com'>nickoneill.com</a>
                    </nav>
                    <article className="post">
                        <header className="post-header">
                            <h1 className="post-title">{header}</h1>
                        </header>

                        <div className="post-content">
                            {children}
                        </div>
                    </article>
                    <p><small>&copy; 2019, <a href='https://www.nickoneill.com'>Nick O'Neill</a></small></p>
                </div>
            </div>
        </div>
    );
};

export { PageWithHeader };