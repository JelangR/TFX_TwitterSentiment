import tensorflow as tf

LABEL_KEY = "Sentiment"
FEATURE_KEY = "Text"

def transformed_name(key):
    return key + "_xf"

def preprocessing_fn(inputs):
    """
    Preprocess input features into transformed features.
    Args:
        inputs: map from feature keys to raw features.
    Returns:
        outputs: map from feature keys to transformed features.
    """
    outputs = {}

    # Convert sparse tensor to dense (with default empty string)
    text = inputs[FEATURE_KEY]
    if isinstance(text, tf.sparse.SparseTensor):
        text = tf.sparse.to_dense(text, default_value="")

    # Transform text to lowercase
    outputs[transformed_name(FEATURE_KEY)] = tf.strings.lower(text)

    # Cast label to int64
    label = tf.cast(inputs[LABEL_KEY], tf.int64)
    outputs[transformed_name(LABEL_KEY)] = label

    return outputs
